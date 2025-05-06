//
//  AnimalsMLModel.swift
//  FinalProject
//
//  Created by Siripoom Jaruphoom on 6/5/25.
//

import UIKit
import CoreML
import Vision

class AnimalsMLModel: NSObject {
    let myUIImage: UIImage
    init(myUIImage: UIImage) {
        self.myUIImage = myUIImage
    }

    func createImageClassifier() -> VNCoreMLModel {
        guard let imageClassifierWrapper = try? AnimalsModel(configuration: MLModelConfiguration()) else {
            fatalError("ไม่สามารถสร้าง Image Classifier Model Instance ได้")
        }
        return try! VNCoreMLModel(for: imageClassifierWrapper.model)
    }

    func classifyingAnimalImage() -> String {
        guard let ciImage = CIImage(image: myUIImage) else {
            fatalError("ไม่สามารถแปลง UIImage เป็น CIImage ได้")
        }

        var classifyingResult = ""
        let request = VNCoreMLRequest(model: createImageClassifier()) { request, _ in
            if let results = request.results as? [VNClassificationObservation],
               let best = results.first {
                let confidence = String(format: "%.2f", best.confidence)
                classifyingResult = "\(best.identifier)\n[confidence = \(confidence)]"
            }
        }
        request.imageCropAndScaleOption = .centerCrop

        let handler = VNImageRequestHandler(ciImage: ciImage)
        try? handler.perform([request])

        return classifyingResult
    }
}
