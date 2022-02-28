//
//  ViewModel.swift
//  WhatFlower
//
//  Created by Mostafa Mahmoud on 2/28/22.
//
import CoreML
import Vision
import Alamofire
import SDWebImage
import SwiftyJSON
import Foundation
class ViewModel
{
    private let networking = Networking()
    public var flowerName:String?
    public var model:FlowerModel?
    
    public func ditictImage(ciimage:CIImage,completion:@escaping()->())
    {
       guard let model = try? VNCoreMLModel(for: FlowerClassifier().model) else
        {
            fatalError("Couldnt load model")
        }
        let request = VNCoreMLRequest(model: model) { request, error in
            if let results = request.results as? [VNClassificationObservation]
            {
                print(results)
                if let firstResult = results.first
                {
                    
                    self.networking.requestInfo(flowerName: firstResult.identifier) { model in
                        self.flowerName = firstResult.identifier
                        self.model = model
                        completion()
                        
                      
                    }
                    
                }
                
            }
        }
        let handler = VNImageRequestHandler(ciImage: ciimage)
        do
        {
            try handler.perform([request])
        }
        catch
        {
            print(error)
        }
        
    }
}
