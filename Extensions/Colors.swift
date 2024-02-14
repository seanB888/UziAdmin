//
//  Colors.swift
//  UZIAdmin
//
//  Created by SEAN BLAKE on 2/3/24.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let armyGreen = Color("ArmyGreen")
    let background = Color("Background")
    let uziBlue = Color("UZiBlue")
    let uziDarkGray = Color("UZiDarkGray")
    let uziMustard = Color("UZiMustard")
    let uziNavy = Color("UZiNavy")
    let uziRed = Color("UZiRed")
    let uziYellow = Color("UZiYellow")
    let uziBrown = Color("UZiBrown")
    let uziPurple = Color("UZiPurple")
    let uziStoneWash = Color("UZiStoneWash")
    
    
    func color(from name: String) -> Color {
        switch name {
        case "AccentColor": return accent
        case "ArmyGreen": return armyGreen
        case "UZiBlue": return uziBlue
        case "UZiDarkGray": return uziDarkGray
        case "UZiMustard": return uziMustard
        case "UZiNavy": return uziNavy
        case "UZiRed": return uziRed
        case "UZiYellow": return uziYellow
        case "UZiBrown": return uziBrown
        case "UZiPurple": return uziPurple
        case "UZiStoneWash": return uziStoneWash
        default: return background
        }
    }
}
