//
//  AnimalType.swift
//  Personal Quiz
//
//  Created by Denis Bystruev on 01/07/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

enum AnimalType: Character {
    case dog = "🐶"
    case cat = "🐱"
    case rabbit = "🐰"
    case turtle = "🐢"
}

// MARK: - Definition
extension AnimalType {
    var definition: String {
        switch self {
        
        case .dog:
            return "Вы любите развлекаться вне дома вместе с людьми, которые вам дороги."
            
        case .cat:
            return "Вы гуляете сами по себе.  Вам не нужна компания, вы цените свободу."
            
        case .rabbit:
            return "Вам нравится всё мягкое.  Вы здоровы и полны энергии."
            
        case .turtle:
            return "Мудрость важнее скорости.  Медленный и вдумчивый всегда выигрывает."
            
        }
    }
}
