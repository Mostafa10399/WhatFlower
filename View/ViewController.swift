//
//  ViewController.swift
//  WhatFlower
//
//  Created by Mostafa Mahmoud on 2/25/22.
//

import UIKit
import CoreML
import Vision
import Alamofire
import SDWebImage
import SwiftyJSON

class ViewController: UIViewController {

   private let viewModel = ViewModel()
    
    @IBOutlet weak var overView: UILabel!
  
    @IBOutlet weak var imageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.scrollEdgeAppearance?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        overView.textColor = UIColor(named: "BackGround")
        // Do any additional setup after loading the view.
    }

    @IBAction func cameraButtonPressed(_ sender: UIBarButtonItem) {
        pickerCheck()
    }
    
}
extension ViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    func pickerCheck()
    {
        let vc = UIImagePickerController()
        vc.allowsEditing = true
        vc.sourceType = .camera
        vc.delegate = self
        present(vc, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {
            
            guard let ciimage = CIImage(image: image) else
            {
                fatalError("Couldnt convertimage")
                
            }
            viewModel.ditictImage(ciimage: ciimage) {
                DispatchQueue.main.async {
                    if let model = self.viewModel.model , let name = self.viewModel.flowerName
                    {
                        self.overView.text=model.flowerOverView
                        self.imageView.sd_setImage(with: URL(string: model.flowerImage))
                        self.navigationItem.title = name
                    }
                   
                }
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    


}
        
