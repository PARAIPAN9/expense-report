import XCTest
@testable import ExpenseReport

final class ExpenseReportTests: XCTestCase {
    
    private var report: ExpenseReport!
    private var printer: MockReportPrinter!
    
    override func setUp() {
        report = ExpenseReport()
        printer = MockReportPrinter()
    }
    
    func testPrintEmpty() throws {
        report.printReport(printer)
        XCTAssertEqual("Expenses 9/12/2002\n" +
                       "\nMeal expenses $0.00\n" +
                       "Total $0.00",
                       printer.printedText)
    }
    
    func testPrintOneDinner() throws {
        report.add(expense: Expense(.dinner, 1678))
        report.printReport(printer)
        XCTAssertEqual("Expenses 9/12/2002\n" +
                       " \tDinner\t$16.78\n" +
                       "\n" +
                       "Meal expenses $16.78\n" +
                       "Total $16.78",
                       printer.printedText)
    }
    
    func testTwoMeals() throws {
        report.add(expense: Expense(.dinner, 1000))
        report.add(expense: Expense(.breakfast, 500))
        report.printReport(printer)
        XCTAssertEqual("Expenses 9/12/2002\n" +
                       " \tDinner\t$10.00\n" +
                       " \tBreakfast\t$5.00\n" +
                       "\n" +
                       "Meal expenses $15.00\n" +
                       "Total $15.00",
                       printer.printedText)
    }
    
    func testTwoMealsAndCarRental() throws {
        report.add(expense: Expense(.dinner, 1000))
        report.add(expense: Expense(.breakfast, 500))
        report.add(expense: Expense(.carRental, 50000))
        report.printReport(printer)
        XCTAssertEqual("Expenses 9/12/2002\n" +
                       " \tDinner\t$10.00\n" +
                       " \tBreakfast\t$5.00\n" +
                       " \tCar Rental\t$500.00\n" +
                       "\n" +
                       "Meal expenses $15.00\n" +
                       "Total $515.00",
                       printer.printedText)
    }
    
    func testOverages() throws {
        report.add(expense: Expense(.breakfast, 1000))
        report.add(expense: Expense(.breakfast, 1001))
        report.add(expense: Expense(.dinner, 5000))
        report.add(expense: Expense(.dinner, 5001))
        report.printReport(printer);
        XCTAssertEqual("Expenses 9/12/2002\n" +
                       " \tBreakfast\t$10.00\n" +
                       "X\tBreakfast\t$10.01\n" +
                       " \tDinner\t$50.00\n" +
                       "X\tDinner\t$50.01\n" +
                       "\n" +
                       "Meal expenses $120.02\n" +
                       "Total $120.02",
                       printer.printedText)
    }
}
