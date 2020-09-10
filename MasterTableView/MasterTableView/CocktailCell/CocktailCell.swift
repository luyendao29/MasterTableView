//
//  CocktailCell.swift
//  MasterTableView
//
//  Created by Boss on 9/9/20.
//  Copyright © 2020 LuyệnĐào. All rights reserved.
//

import UIKit


class CocktailCell: BaseTableViewCell, UITextViewDelegate {
    
    @IBOutlet weak var strGlassTextView: UITextView!
    @IBOutlet weak var strInstructionsTextView: UITextView!
    @IBOutlet weak var strDrinkThumbTextView: UITextView!
    @IBOutlet weak var infoImageView: UIImageView!
    
    var infoCocktail = CocktailModel()
    var passObject: ((_ data: CocktailModel) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        strDrinkThumbTextView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fillData() {
//        infoImageView.isHidden = true
        strGlassTextView.text = infoCocktail.strGlass
        strInstructionsTextView.text = infoCocktail.strInstructions
        strDrinkThumbTextView.text = infoCocktail.strDrinkThumb
    }
    
    func loadImage() {
        if let link = infoCocktail.strDrinkThumb {
            DispatchQueue.global().sync {
                guard let url = URL(string: link) else {return}
                guard let data = try? Data(contentsOf: url) else {return}
                DispatchQueue.main.async {
                    self.strDrinkThumbTextView.isHidden = true
                    self.infoImageView.isHidden = false
                    self.infoImageView.image = UIImage(data: data)
//                    self.infoImageView.alpha = 0.3
//                    UIView.animate(withDuration: 0.35, animations: {
//                        self.infoImageView.alpha = 1
//                    })
                }
            }
        }
    }
    func setData() {
        infoCocktail.strGlass = strGlassTextView.text
        infoCocktail.strDrinkThumb = strDrinkThumbTextView.text
        infoCocktail.strInstructions = strInstructionsTextView.text
    }
    func textViewDidChange(_ textView: UITextView) {
        setData()
        passObject?(infoCocktail)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == strDrinkThumbTextView {
            loadImage()
            strDrinkThumbTextView.resignFirstResponder()
        }
    }
    
//    override func prepareForReuse() {
////        infoImageView.image = UIImage()
////        infoImageView.image = UIImage()
//        //backgroundColor = .white
////        strGlassTextView.text = ""
////        strInstructionsTextView.text = ""
////        strDrinkThumbTextView.text = ""
//    }
    
}
