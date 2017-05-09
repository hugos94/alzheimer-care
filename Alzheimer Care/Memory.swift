//
//  Audio.swift
//  Alzheimer Care
//
//  Created by Student on 08/05/17.
//  Copyright © 2017 Hugo Santos Piauilino. All rights reserved.
//

import Foundation

class Memory {
    let name: String
    let date: Date
    let dateFormatter = DateFormatter()
    var audio: NSURL
    var formattedDate: String = ""
    
    init(name: String, date: Date, audio: NSURL) {
        
        self.name = name
        self.date = date
        self.audio = audio
    
    }
    
    func getFormattedData() -> String {
        return "\(getWeekDay()), \(getDay()) de \(getMonth()) de \(getYear()) - \(getTime())"
        
    }
    
    private func getTime() -> String {
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    private func getDay() -> String {
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: date)
    }
    
    private func getYear() -> String {
        dateFormatter.dateFormat = "yyy"
        return dateFormatter.string(from: date)
    }
    
    // Dá pra criar algo com Enum, mas eu estava sem ideia :/
    private func getMonth() -> String {
        
        dateFormatter.dateFormat = "MMM"
        
        let month = dateFormatter.string(from: date)
        
        switch month {
        case "Jan":
            return "Janeiro"
        case "Feb":
            return "Fevereiro"
        case "Mar":
            return "Março"
        case "Apr":
            return "Abril"
        case "May":
            return "Maio"
        case "Jun":
            return "Junho"
        case "Jul":
            return "Julho"
        case "Aug":
            return "Agosto"
        case "Sep":
            return "Setembro"
        case "Oct":
            return "Outubro"
        case "Nov":
            return "Novembro"
        case "Dec":
            return "Dezembro"
        default:
            return "Mês Inválido!"
        }
    }
    
    // Dá pra criar algo com Enum, mas eu estava sem ideia :/
    private func getWeekDay() -> String {
        dateFormatter.dateFormat = "EEE"
        let weekDay = dateFormatter.string(from: date)
        
        switch weekDay {
        case "Sun":
            return "Domingo"
        case "Mon":
            return "Segunda"
        case "Tue":
            return "Terça"
        case "Wed":
            return "Quarta"
        case "Thu":
            return "Quinta"
        case "Fri":
            return "Sexta"
        case "Sat":
            return "Sábado"
        default:
            return "Dia da Semana Inválido!"
        }
    }
    
}
