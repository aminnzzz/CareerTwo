import UIKit

//let formatter = DateFormatter()
//formatter.locale = Locale(identifier: "en_US@calendar=japanese")
//formatter.dateFormat = "dd/MM/yyyy"
//print(formatter.string(from: Date()))



let formatter = DateFormatter()
formatter.locale = Locale(identifier: "en_US@calendar=japanese")
formatter.dateStyle = .long
formatter.timeStyle = .full
print(formatter.string(from: Date()))

//let formatter = DateFormatter()
//formatter.locale = Locale(identifier: "en_US")
//formatter.setLocalizedDateFormatFromTemplate("dMy")
//print(formatter.string(from: Date()))
