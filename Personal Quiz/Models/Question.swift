//
//  Question.swift
//  Personal Quiz
//
//  Created by Denis Bystruev on 01/07/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
    
    static var all: [Question] {
        return [
            Question(text: "Какую еду вы предпочитаете?", type: .single, answers: [
                Answer(text: "Стейк", type: .dog),
                Answer(text: "Рыба", type: .cat),
                Answer(text: "Морковка", type: .rabbit),
                Answer(text: "Капуста", type: .turtle),
            ]),
            Question(text: "Что вам нравится делать?", type: .multiple, answers: [
                Answer(text: "Плавать", type: .turtle),
                Answer(text: "Спать", type: .cat),
                Answer(text: "Обниматься", type: .rabbit),
                Answer(text: "Есть", type: .dog),
            ]),
            Question(text: "Любите ли вы езду на машине?", type: .ranged, answers: [
                Answer(text: "Ненавижу", type: .cat),
                Answer(text: "Немного нервничаю", type: .rabbit),
                Answer(text: "Почти не замечаю", type: .turtle),
                Answer(text: "Обожаю", type: .dog),
            ]),
        ]
    }
}
