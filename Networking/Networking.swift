//
//  Networking.swift
//  WhatFlower
//
//  Created by Mostafa Mahmoud on 2/26/22.
import Alamofire
import SDWebImage
import SwiftyJSON
import Foundation
struct Networking
{
    func requestInfo (flowerName:String, completion: @escaping (FlowerModel) -> Void) {
    
        let stringURL = "https://en.wikipedia.org/w/api.php?format=json"
        let parameters : [String:String] = [
          "format" : "json",
          "action" : "query",
          "prop" : "extracts|pageimages",
          "exintro" : "",
          "explaintext" : "",
          "titles" : flowerName,
          "indexpageids" : "",
          "redirects" : "1",
          "pithumbsize": "500"
          ]
        Alamofire.request(stringURL, method: .get, parameters: parameters).responseJSON { response in
            if response.result.isSuccess
            {
                print("got wikipidiea data")
                print(JSON(response.result.value!))
                let flowerJSON:JSON = JSON(response.result.value!)
                let pageid = flowerJSON["query"]["pageids"][0].stringValue
                let overView = flowerJSON["query"]["pages"][pageid]["extract"].stringValue
                let flowerImage = flowerJSON["query"]["pages"][pageid]["thumbnail"]["source"].stringValue
                print(flowerImage)
                print(overView)
                let model = FlowerModel(flowerImage: flowerImage, flowerOverView: overView)
                completion(model)
                
            }
            
        }
        }
        
    }

