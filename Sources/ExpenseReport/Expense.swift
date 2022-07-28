
struct Expense {
    
    enum `Type` {
        case dinner
        case breakfast
        case carRental
    }
    let type: `Type`
    let amount: Double
    
    init(_ type: `Type`, _ amount: Double) {
        self.type = type
        self.amount = amount
    }
}
