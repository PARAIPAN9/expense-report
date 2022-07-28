import Foundation

class ExpenseReport {
    
    private var expenses: [Expense] = []
    private var date: String { "9/12/2002" }
    
    func printReport(_ printer: ReportPrinter) {
        var total = 0.0
        var mealExpenses = 0.0
        
        printer.print(text: "Expenses " + date + "\n")
        
        for expense in expenses {
            var name = "TILT"
            switch expense.type {
            case .dinner:
                name = "Dinner"
                mealExpenses += expense.amount
            case .breakfast:
                name = "Breakfast"
                mealExpenses += expense.amount
            case .carRental:
                name = "Car Rental"
            }
            printer.print(text: String(format: "%@\t%@\t$%.02f\n",
                                       ((expense.type == .dinner && expense.amount > 5000)
                                        || (expense.type == .breakfast && expense.amount > 1000)) ? "X" : " ",
                                       name, expense.amount / 100))
            total += expense.amount
        }
        printer.print(text: String(format: "\nMeal expenses $%.02f", mealExpenses / 100))
        printer.print(text: String(format: "\nTotal $%.02f", total / 100))
    }
    
    func add(expense: Expense) {
        expenses.append(expense)
    }
}
