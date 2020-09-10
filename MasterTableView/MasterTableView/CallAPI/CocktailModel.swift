//
//  CocktailModel.swift
//  MasterTableView
//
//  Created by Boss on 9/9/20.
//  Copyright © 2020 LuyệnĐào. All rights reserved.
//

import UIKit

struct BaseDataModel: Codable {
    var drinks: [CocktailModel]?
}
struct CocktailModel: Codable {
    var strGlass: String?
    var strInstructions: String?
    var strDrinkThumb: String?
}
