import XCTest
@testable import JSSwift

/// A running count of all the contexts that have been created and not destroyed
private final class JXDebugContext : JXContext {
    static var debugContextCount = 0

    convenience init() {
        self.init(group: JXContextGroup())
    }

    override init(group: JXContextGroup) {
        super.init(group: group)
        Self.debugContextCount += 1
    }

    deinit {
        Self.debugContextCount -= 1
    }
}


/// A running count of all the values that have been created and not destroyed
private final class JXDebugValue : JXValue {
    static var debugValueCount = 0

    override init(env: JXContext, value: OpaquePointer) {
        Self.debugValueCount += 1
        super.init(env: env, value: value)
    }

    deinit {
        Self.debugValueCount -= 1
    }
}

final class JSSwiftTests: XCTestCase {
    /// Ensure that contexts are destroued as expected
    func testJSSwiftContext() throws {
        XCTAssertEqual(0, JXDebugContext.debugContextCount)
        defer { XCTAssertEqual(0, JXDebugContext.debugContextCount, "context did not deinit") }

        do {
            let ctx = JXDebugContext()
            XCTAssertEqual(1, JXDebugContext.debugContextCount)

            let parser = try JavaScriptParser(ctx: ctx)

            let topts = JavaScriptParser.TokenizeOptions(loc: true)
            let popts = JavaScriptParser.ParseOptions(loc: true)

            func tokenize(js javaScript: String, tokenTypes: [JSTokenType]? = nil, columns: [Int]? = nil, line: UInt = #line) throws {
                let tokenList = try parser.tokenize(javaScript: javaScript, options: topts)

                if let tokenTypes = tokenTypes {
                    XCTAssertEqual(tokenTypes, tokenList.map(\.type), line: line)
                }

                if let columns = columns {
                    XCTAssertEqual(columns, tokenList.map(\.loc?.start.column), line: line)
                }
            }

            // tokenization tests

            try tokenize(js: "1.2", tokenTypes: [.NumericLiteral])
            try tokenize(js: "'WAT'", tokenTypes: [.StringLiteral])

            try tokenize(js: "const answer = 42", tokenTypes: [.Keyword, .Identifier, .Punctuator, .NumericLiteral])

            try tokenize(js: "1+2", tokenTypes: [.NumericLiteral, .Punctuator, .NumericLiteral], columns: [0, 1, 2])
            try tokenize(js: "1+'x'", tokenTypes: [.NumericLiteral, .Punctuator, .StringLiteral], columns: [0, 1, 2])
            try tokenize(js: "1+[]", tokenTypes: [.NumericLiteral, .Punctuator, .Punctuator, .Punctuator], columns: [0, 1, 2, 3])

            
            /// AST examples

            XCTAssertEqual(try parser.parse(javaScript: "const answer = 42", options: popts), JSSyntax.Script(type: .Program, body: [
                .init(.init(JSSyntax.VariableDeclaration(type: .VariableDeclaration, declarations: [
                    JSSyntax.VariableDeclarator(type: .VariableDeclarator, id: oneOf(JSSyntax.Identifier(type: .Identifier, name: "answer")), init: oneOf(oneOf(oneOf(JSSyntax.Literal(type: .Literal, value: .v2(42.0), raw: "42")))))
                ], kind: "const")))
            ], sourceType: "script"))

            XCTAssertEqual(try parser.parse(javaScript: "1.2 + 'ABC'", options: popts), JSSyntax.Script(type: .Program, body: [
                JSSyntax.StatementListItem(JSSyntax.Statement(oneOf(JSSyntax.ExpressionStatement(type: .ExpressionStatement, expression: JSSyntax.Expression(oneOf(JSSyntax.BinaryExpression(type: .BinaryExpression, operator: "+", left: oneOf(oneOf(JSSyntax.Literal(type: .Literal, value: oneOf(1.2), raw: "1.2"))), right: oneOf(oneOf(JSSyntax.Literal(type: .Literal, value: oneOf("ABC"), raw: "'ABC'"))))))))))
            ], sourceType: "script"))


            XCTAssertEqual(try parser.parse(javaScript: "'XYZ'+1.2", options: popts), JSSyntax.Script(type: .Program, body: [
                JSSyntax.StatementListItem(JSSyntax.Statement(oneOf(JSSyntax.ExpressionStatement(type: .ExpressionStatement, expression: JSSyntax.Expression(oneOf(JSSyntax.BinaryExpression(type: .BinaryExpression, operator: "+", left: oneOf(oneOf(JSSyntax.Literal(type: .Literal, value: oneOf("XYZ"), raw: "'XYZ'"))), right: oneOf(oneOf(JSSyntax.Literal(type: .Literal, value: oneOf(1.2), raw: "1.2"))))))))))
            ], sourceType: "script"))


            /// Checks that the given JavaScript can be parsed
            func parse(js javaScript: String, tokenTypes: [JSTokenType]? = nil, tolerant: Bool = false, columns: [Int]? = nil, line: UInt = #line) throws {
                var opts = popts
                opts.tolerant = tolerant
                let _ = try parser.parse(javaScript: javaScript, options: opts)
            }

            try parse(js: "function doSomething() { return 1 + 'abx'; }")
//            try parse(js: "{}")
//            try parse(js: "{{}}")
//            try parse(js: "function doSomething() { abc(); }")
//            try parse(js: "function doSomething() { { } }")
//            try parse(js: "function doSomething() { for (var i = 0; i < 10; i++) { } }")

//            guard let url = JXContext.SwiftJSResourceURL else {
//                return XCTFail("no resource URL")
//            }
//
//            let scriptString = try String(contentsOf: url)
//            measure {
//                do {
//                    try parser.parse(javaScript: scriptString)
//                } catch {
//                    XCTFail("error measuring performance: \(error)")
//                }
//            }
        }
    }
}
