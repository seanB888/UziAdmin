//
//  ColorModel.swift
//  UZIAdmin
//
//  Created by SEAN BLAKE on 2/23/24.
//

import SwiftUI

class ColorListModel: ObservableObject {
    @Published var colors = colorList
}

struct ColorModel: Identifiable, Hashable {
    var id: UUID = .init()
    var colorName: String
    var name: String
}

var colorList: [ColorModel] = [
    ColorModel(colorName: "AccentColor", name: "accent"),
    ColorModel(colorName: "ArmyGreen", name: "armyGreen"),
    ColorModel(colorName: "Background", name: "background"),
    ColorModel(colorName: "UziBlue", name: "uziBlue"),
    ColorModel(colorName: "UziDarkGray", name: "uziDarkGray"),
    ColorModel(colorName: "UziMustard", name: "uziMustard"),
    ColorModel(colorName: "UziNavy", name: "uziNavy"),
    ColorModel(colorName: "UziRed", name: "uziRed"),
    ColorModel(colorName: "UziYellow", name: "uziYellow"),
    ColorModel(colorName: "UziBrown", name: "uziBrown"),
    ColorModel(colorName: "UziPurple", name: "uziPurple"),
    ColorModel(colorName: "UziStoneWash", name: "uziStoneWash")
]
