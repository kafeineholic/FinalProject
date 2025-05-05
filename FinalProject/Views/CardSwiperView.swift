//
//  CardSwiperView.swift
//  FinalProject
//
//  Created by Pattranith Ruangrotch on 4/5/2568 BE.
//

import SwiftUI

/// ทิศทางการสไลด์การ์ด
public enum SwipeDirection: CaseIterable {
	case left, right, top, bottom
	
	/// ค่า threshold สำหรับการสไลด์
	var thresholdPercentage: CGFloat {
		0.25
	}
}

/// คอนฟิกสำหรับ Card Swiper
public struct CardSwiperConfig {
	public var cardSize: CGSize
	public var swipeThreshold: CGFloat
	public var maxSwipeDistance: CGFloat
	public var rotationAngleFactor: Double
	public var scaleFactor: CGFloat
	public var animation: Animation
	
	public init(
		cardSize: CGSize = CGSize(width: 320, height: 420),
		swipeThreshold: CGFloat = 100,
		maxSwipeDistance: CGFloat = 500,
		rotationAngleFactor: Double = 0.25,
		scaleFactor: CGFloat = 0.9,
		animation: Animation = .interactiveSpring()
	) {
		self.cardSize = cardSize
		self.swipeThreshold = swipeThreshold
		self.maxSwipeDistance = maxSwipeDistance
		self.rotationAngleFactor = rotationAngleFactor
		self.scaleFactor = scaleFactor
		self.animation = animation
	}
}

/// ตัว Card Swiper หลัก
public struct CardSwiperView<Data: Identifiable, Content: View>: View {
	@Binding private var items: [Data]
	private let content: (Data) -> Content
	private var config: CardSwiperConfig
	private var onSwiped: ((SwipeDirection, Data) -> Void)?
	private var onDragged: ((SwipeDirection, Data, CGSize) -> Void)?
	private var overlayView: ((SwipeDirection) -> AnyView)?
	
	public init(
		items: Binding<[Data]>,
		config: CardSwiperConfig = CardSwiperConfig(),
		@ViewBuilder content: @escaping (Data) -> Content,
		onSwiped: ((SwipeDirection, Data) -> Void)? = nil,
		onDragged: ((SwipeDirection, Data, CGSize) -> Void)? = nil,
		overlayView: ((SwipeDirection) -> AnyView)? = nil
	) {
		self._items = items
		self.config = config
		self.content = content
		self.onSwiped = onSwiped
		self.onDragged = onDragged
		self.overlayView = overlayView
	}
	
	public var body: some View {
		ZStack {
			ForEach(items) { item in
				CardView(
					item: item,
					config: config,
					content: { content(item) },
					overlayView: overlayView,
					onSwiped: { direction in
						onSwiped?(direction, item)
					},
					onDragged: { direction, offset in
						onDragged?(direction, item, offset)
					}
				)
				.zIndex(zIndex(for: item))
			}
		}
		.frame(width: config.cardSize.width, height: config.cardSize.height)
	}
	
	private func zIndex(for item: Data) -> Double {
		Double(items.firstIndex { $0.id == item.id } ?? 0)
	}
}

/// ตัวการ์ดแต่ละใบ
private struct CardView<Data: Identifiable, Content: View>: View {
	let item: Data
	let config: CardSwiperConfig
	let content: () -> Content
	let overlayView: ((SwipeDirection) -> AnyView)?
	let onSwiped: (SwipeDirection) -> Void
	let onDragged: (SwipeDirection, CGSize) -> Void
	
	@State private var offset = CGSize.zero
	@State private var scale: CGFloat = 1.0
	@State private var overlayDirection: SwipeDirection?
	
	var body: some View {
		content()
			.frame(width: config.cardSize.width, height: config.cardSize.height)
			.offset(offset)
			.rotationEffect(rotationAngle)
			.scaleEffect(scale)
			.animation(config.animation, value: offset)
			.animation(config.animation, value: scale)
			.gesture(dragGesture)
	}
	
	private var rotationAngle: Angle {
		Angle(degrees: Double(offset.width / 20) * config.rotationAngleFactor)
	}
	
	
	private func defaultOverlay(for direction: SwipeDirection) -> some View {
		RoundedRectangle(cornerRadius: 12)
			.frame(width: config.cardSize.width, height: config.cardSize.height)
	}
	
	private var dragGesture: some Gesture {
		DragGesture()
			.onChanged { gesture in
				offset = gesture.translation
				scale = calculateScaleEffect()
				updateOverlayDirection()
				notifyDrag()
			}
			.onEnded { _ in
				handleSwipe()
			}
	}
	
	private func calculateScaleEffect() -> CGFloat {
		let totalOffset = sqrt(pow(offset.width, 2) + pow(offset.height, 2))
		let scaleReduction = min(totalOffset / 1000, 1.0 - config.scaleFactor)
		return max(config.scaleFactor, 1.0 - scaleReduction)
	}
	
	private func updateOverlayDirection() {
		let direction = determineSwipeDirection()
		overlayDirection = direction.0
	}
	
	private func notifyDrag() {
		let (direction, _) = determineSwipeDirection()
		onDragged(direction, offset)
	}
	
	private func handleSwipe() {
		let (direction, shouldSwipe) = determineSwipeDirection()
		
		if shouldSwipe {
			withAnimation(config.animation) {
				offset = finalOffset(for: direction)
				scale = config.scaleFactor
			}
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
				onSwiped(direction)
			}
		} else {
			withAnimation(config.animation) {
				offset = .zero
				scale = 1.0
				overlayDirection = nil
			}
		}
	}
	
	private func determineSwipeDirection() -> (SwipeDirection, Bool) {
		let width = offset.width
		let height = offset.height
		let threshold = config.swipeThreshold
		
		if width < -threshold {
			return (.left, true)
		} else if width > threshold {
			return (.right, true)
		} else if height < -threshold {
			return (.top, true)
		} else if height > threshold {
			return (.bottom, true)
		}
		
		return (.left, false)
	}
	
	private func finalOffset(for direction: SwipeDirection) -> CGSize {
		switch direction {
		case .left: return CGSize(width: -config.maxSwipeDistance, height: 0)
		case .right: return CGSize(width: config.maxSwipeDistance, height: 0)
		case .top: return CGSize(width: 0, height: -config.maxSwipeDistance)
		case .bottom: return CGSize(width: 0, height: config.maxSwipeDistance)
		}
	}
}

// MARK: - View Modifiers
public extension CardSwiperView {
	func onSwiped(_ action: @escaping (SwipeDirection, Data) -> Void) -> Self {
		var copy = self
		copy.onSwiped = action
		return copy
	}
	
	func onDragged(_ action: @escaping (SwipeDirection, Data, CGSize) -> Void) -> Self {
		var copy = self
		copy.onDragged = action
		return copy
	}
	
	func overlayView<Overlay: View>(_ view: @escaping (SwipeDirection) -> Overlay) -> Self {
		var copy = self
		copy.overlayView = { direction in
			let built = view(direction)
			return AnyView(built)
		}
		return copy
	}
	
	func config(_ config: CardSwiperConfig) -> Self {
		var copy = self
		copy.config = config
		return copy
	}
}

// MARK: - Preview
struct CardSwiperView_Previews: PreviewProvider {
	struct DemoItem: Identifiable {
		let id = UUID()
		let title: String
		let color: Color
	}
	
	@State static var items = [
		DemoItem(title: "Card 1", color: .red),
		DemoItem(title: "Card 2", color: .blue),
		DemoItem(title: "Card 3", color: .green)
	]
	
	static var previews: some View {
		CardSwiperView(items: $items) { item in
			RoundedRectangle(cornerRadius: 20)
				.fill(item.color)
				.overlay(
					Text(item.title)
						.font(.largeTitle)
						.foregroundColor(.white)
				)
		}
		.onSwiped { direction, item in
			print("Swiped \(item.title) to \(direction)")
		}
		.config(CardSwiperConfig(
			cardSize: CGSize(width: 300, height: 400),
			swipeThreshold: 100))
	}
}
