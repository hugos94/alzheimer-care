//
//  PhysicalActivityDetailsViewController.swift
//  Alzheimer Care
//
//  Created by Student on 5/10/17.
//  Copyright © 2017 Hugo Santos Piauilino. All rights reserved.
//

import UIKit
import UserNotifications

class PhysicalActivityDetailsViewController: UIViewController {
  
  @IBOutlet weak var descriptionTextView: UITextView!
  @IBOutlet weak var timeDatePicker: UIDatePicker!
  
  @IBOutlet weak var sundaySwitch: UISwitch!
  @IBOutlet weak var mondaySwitch: UISwitch!
  @IBOutlet weak var tuesdaySwitch: UISwitch!
  @IBOutlet weak var wednesdaySwitch: UISwitch!
  @IBOutlet weak var thursdaySwitch: UISwitch!
  @IBOutlet weak var fridaySwitch: UISwitch!
  @IBOutlet weak var saturdaySwitch: UISwitch!
  
  var activity = Activity(name: "", description: "", time: "", frequency: [])
  
  @IBAction func OK() {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat =  "HH:mm"
    
    activity.time = dateFormatter.string(from: timeDatePicker.date)
    
    activity.frequency = []
    
    if sundaySwitch.isOn {
      activity.frequency.append(.Sunday)
    }
    if mondaySwitch.isOn {
      activity.frequency.append(.Monday)
    }
    if tuesdaySwitch.isOn {
      activity.frequency.append(.Tuesday)
    }
    if wednesdaySwitch.isOn {
      activity.frequency.append(.Wednesday)
    }
    if thursdaySwitch.isOn {
      activity.frequency.append(.Thursday)
    }
    if fridaySwitch.isOn {
      activity.frequency.append(.Friday)
    }
    if saturdaySwitch.isOn {
      activity.frequency.append(.Saturday)
    }
    
    scheduleNotification()
    
    print("Entrou aqui")
    
    dismiss(animated: false, completion: nil)
  }
  
  func scheduleNotification() {
    
    // Definimos o intervalo de tempo para disparar a ação
    //        var timeInterval = 10.0
    //        if repeating {
    // Se a notificação for se repetir o mínimo é de 60 segundos
    //            timeInterval = 60.0
    //        }
    
    // Defina o gatilho da notificação
    // O gatilho pode ser de várias formas, uma delas é intervalo de tempo
    //        let trigger = UNTimeIntervalNotificationTrigger(
    //            timeInterval: timeInterval,
    //            repeats: true
    //        )
    
    // Crie um request de notificação com
    //  - Identificação: identifica a notificação unicamente
    //  - Conteúdo: define o conteúdo da notificação
    //  - Gatilho: define quando a notificação será ativada
    //        let request = UNNotificationRequest(
    //            identifier: "\(activity.name).notification",
    //            content: content,
    //            trigger: trigger
    //        )
    
    // Pegue a instância unica do notification center no app
    let notificationCenter = UNUserNotificationCenter.current()
    
    let time = activity.time.components(separatedBy: ":")
    print(activity.time)
    print(time)
    let hour = Int(time[0])
    let minute = Int(time[1])
    
    if activity.frequency.contains(.Sunday){
      
      let trigger = UNCalendarNotificationTrigger(
        dateMatching: DateComponents(hour: hour, minute: minute, weekday: 1), repeats: true)
      
      let identifier = "\(activity.name)1.notification"
      
      addToNotificationCenter(notificationCenter: notificationCenter, identifier: identifier, trigger: trigger)
    } else {
      notificationCenter.removePendingNotificationRequests(withIdentifiers: ["\(activity.name)1.notification"])
    }
    
    if activity.frequency.contains(.Monday){
      
      let trigger = UNCalendarNotificationTrigger(
        dateMatching: DateComponents(hour: hour, minute: minute, weekday: 2), repeats: true)
      
      let identifier = "\(activity.name)2.notification"
      
      addToNotificationCenter(notificationCenter: notificationCenter, identifier: identifier, trigger: trigger)
    } else {
      notificationCenter.removePendingNotificationRequests(withIdentifiers: ["\(activity.name)2.notification"])
    }
    
    if activity.frequency.contains(.Tuesday){
      
      let trigger = UNCalendarNotificationTrigger(
        dateMatching: DateComponents(hour: hour, minute: minute, weekday: 3), repeats: true)
      
      let identifier = "\(activity.name)3.notification"
      
      addToNotificationCenter(notificationCenter: notificationCenter, identifier: identifier, trigger: trigger)
    } else {
      notificationCenter.removePendingNotificationRequests(withIdentifiers: ["\(activity.name)3.notification"])
    }
    
    if activity.frequency.contains(.Wednesday){
      
      let trigger = UNCalendarNotificationTrigger(
        dateMatching: DateComponents(hour: hour, minute: minute, weekday: 4), repeats: true)
      
      let identifier = "\(activity.name)4.notification"
      
      addToNotificationCenter(notificationCenter: notificationCenter, identifier: identifier, trigger: trigger)
    } else {
      notificationCenter.removePendingNotificationRequests(withIdentifiers: ["\(activity.name)4.notification"])
    }
    
    if activity.frequency.contains(.Thursday){
      
      let trigger = UNCalendarNotificationTrigger(
        dateMatching: DateComponents(hour: hour, minute: minute, weekday: 5), repeats: true)
      
      let identifier = "\(activity.name)5.notification"
      
      addToNotificationCenter(notificationCenter: notificationCenter, identifier: identifier, trigger: trigger)
    } else {
      notificationCenter.removePendingNotificationRequests(withIdentifiers: ["\(activity.name)5.notification"])
    }
    
    if activity.frequency.contains(.Friday){
      
      let trigger = UNCalendarNotificationTrigger(
        dateMatching: DateComponents(hour: hour, minute: minute, weekday: 6), repeats: true)
      
      let identifier = "\(activity.name)6.notification"
      
      addToNotificationCenter(notificationCenter: notificationCenter, identifier: identifier, trigger: trigger)
    } else {
      notificationCenter.removePendingNotificationRequests(withIdentifiers: ["\(activity.name)6.notification"])
    }
    
    if activity.frequency.contains(.Saturday){
      
      let trigger = UNCalendarNotificationTrigger(
        dateMatching: DateComponents(hour: hour, minute: minute, weekday: 7), repeats: true)
      
      let identifier = "\(activity.name)7.notification"
      
      addToNotificationCenter(notificationCenter: notificationCenter, identifier: identifier, trigger: trigger)
    } else {
      notificationCenter.removePendingNotificationRequests(withIdentifiers: ["\(activity.name)7.notification"])
    }
    
    /* let myOwnDate = Date()
     DateFormatter().dateFormat = "dd/MM/yyyy"
     let currentDate = DateFormatter().string(from: myOwnDate)
     let dateTime = currentDate + " " + activity.time
     DateFormatter().dateFormat = "dd/MM/yyyy hh:mm a"
     let date = DateFormatter().date(from: dateTime)!
     let x : UILocalNotification
     trigger.date = date
     localNotification.repeatInterval = NSCalendar.Unit.weekday
     localNotification.alertBody = "Your alarm is ringing!"
     let app = UIApplication.shared
     app.scheduleLocalNotification(localNotification) */
    
  }
  
  private func addToNotificationCenter(notificationCenter: UNUserNotificationCenter, identifier: String, trigger: UNCalendarNotificationTrigger){
    
    // Defina o conteúdo da notificação
    let content = UNMutableNotificationContent()
    content.title = "Hora de praticar exercícios"
    content.subtitle = "Vamos tentar a \(activity.name)"
    content.body = "Aprenda aqui como executar esta atividade corretamente"
    content.sound = UNNotificationSound.default()
    
    let request = UNNotificationRequest(
      identifier: identifier,
      content: content,
      trigger: trigger
    )
    
    // Aqui só removemos as notificações anteriores
    notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
    //        notificationCenter.removeAllPendingNotificationRequests()
    
    // Agora adicionamos nossa request de notificação no notification center
    notificationCenter.add(request) { (error) in
      if error != nil{
        print("Ops, temos um erro aqui! Veja: \(error)")
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    timeDatePicker.datePickerMode = UIDatePickerMode.time
    
    descriptionTextView.text = activity.description
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat =  "HH:mm"
    let date = dateFormatter.date(from: activity.time)
    timeDatePicker.date = date!
    
    if !activity.frequency.contains(.Sunday) {
      sundaySwitch.isOn = false
    }
    if !activity.frequency.contains(.Monday) {
      mondaySwitch.isOn = false
    }
    if !activity.frequency.contains(.Tuesday) {
      tuesdaySwitch.isOn = false
    }
    if !activity.frequency.contains(.Wednesday) {
      wednesdaySwitch.isOn = false
    }
    if !activity.frequency.contains(.Thursday) {
      thursdaySwitch.isOn = false
    }
    if !activity.frequency.contains(.Friday) {
      fridaySwitch.isOn = false
    }
    if !activity.frequency.contains(.Saturday) {
      saturdaySwitch.isOn = false
    }
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
