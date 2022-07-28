 
class MockReportPrinter: ReportPrinter {
    
    private(set) var printedText = ""
    
    func print(text: String) {
        printedText += text
    }
}
