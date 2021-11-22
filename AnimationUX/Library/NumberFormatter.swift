import Foundation

extension NumberFormatter {

    static var rubNumberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "RU-ru")
        numberFormatter.numberStyle = .currency
        return numberFormatter
    }

}
