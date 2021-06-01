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

/// Options for parsing
public struct ParserOptions : Encodable {
    /// Whether the parser should include the source location
    ///
    /// - SeeAlso: JSToken.loc
    public var loc: Bool?

    /// Whether the parser should include the range
    ///
    /// - SeeAlso: JSToken.range

    public var range: Bool?

    /// Whether the parser should include comments AST nodes
    public var comment: Bool?

    public init(loc: Bool? = nil, range: Bool? = nil, comment: Bool? = nil) {
        self.loc = loc
        self.range = range
        self.comment = comment
    }
}

final class JSSwiftTests: XCTestCase {
    /// Ensure that contexts are destroued as expected
    func testJSSwiftContext() throws {
        XCTAssertEqual(0, JXDebugContext.debugContextCount)

        defer {
            XCTAssertEqual(0, JXDebugContext.debugContextCount, "context did not deinit")
        }

        do {
            let ctx = JXDebugContext()
            XCTAssertEqual(1, JXDebugContext.debugContextCount)

            let esprima = try ctx.installJSSwift()
            //debugPrint("installed", esprima)


            func tokenize(js javaScript: String, tokenTypes: [JSTokenType]? = nil, columns: [Int]? = nil, line: UInt = #line) throws {
                let opts = ParserOptions(loc: true)

                XCTAssertTrue(esprima.isObject)
                let tokenize = esprima["tokenize"]
                XCTAssertTrue(tokenize.isFunction)

                let tokenized = try ctx.trying { try tokenize.call(withArguments: [ctx.string(javaScript), ctx.encode(opts)]) }

                //print("received", try! tokenized.toJSON(indent: 2))
                let tokenList = try tokenized.toDecodable(ofType: [JSToken].self)
                //print("tokens", tokens)

                if let tokenTypes = tokenTypes {
                    XCTAssertEqual(tokenTypes, tokenList.map(\.type), line: line)
                }

                if let columns = columns {
                    XCTAssertEqual(columns, tokenList.map(\.loc?.start.column), line: line)
                }
            }

            try tokenize(js: "1.2", tokenTypes: [.NumericLiteral])
            try tokenize(js: "'WAT'", tokenTypes: [.StringLiteral])

            try tokenize(js: "const answer = 42", tokenTypes: [.Keyword, .Identifier, .Punctuator, .NumericLiteral])

            try tokenize(js: "1+2", tokenTypes: [.NumericLiteral, .Punctuator, .NumericLiteral], columns: [0, 1, 2])
            try tokenize(js: "1+'x'", tokenTypes: [.NumericLiteral, .Punctuator, .StringLiteral], columns: [0, 1, 2])
            try tokenize(js: "1+[]", tokenTypes: [.NumericLiteral, .Punctuator, .Punctuator, .Punctuator], columns: [0, 1, 2, 3])

            

            func parse(js javaScript: String, line: UInt = #line) throws -> JSSyntax.Script {
                XCTAssertTrue(esprima.isObject)
                let parse = esprima["parse"]
                XCTAssertTrue(parse.isFunction)

                let parsed = try ctx.trying { parse.call(withArguments: [ctx.string(javaScript)]) }

                print("parsed", try! parsed.toJSON(indent: 2))
                let script = try parsed.toDecodable(ofType: JSSyntax.Script.self)
                print("script", script)
                return script
            }

            XCTAssertEqual(try parse(js: "1.2 + 'ABC'"), JSSyntax.Script(type: .Program, body: [
                JSSyntax.StatementListItem(JSSyntax.Statement(oneOf(JSSyntax.ExpressionStatement(type: .ExpressionStatement, expression: JSSyntax.Expression(oneOf(JSSyntax.BinaryExpression(type: .BinaryExpression, operator: "+", left: oneOf(oneOf(JSSyntax.Literal(type: .Literal, value: oneOf(1.2), raw: "1.2"))), right: oneOf(oneOf(JSSyntax.Literal(type: .Literal, value: oneOf("ABC"), raw: "'ABC'"))))))))))
            ], sourceType: "script"))


            XCTAssertEqual(try parse(js: "'XYZ'+1.2"), JSSyntax.Script(type: .Program, body: [
                JSSyntax.StatementListItem(JSSyntax.Statement(oneOf(JSSyntax.ExpressionStatement(type: .ExpressionStatement, expression: JSSyntax.Expression(oneOf(JSSyntax.BinaryExpression(type: .BinaryExpression, operator: "+", left: oneOf(oneOf(JSSyntax.Literal(type: .Literal, value: oneOf("XYZ"), raw: "'XYZ'"))), right: oneOf(oneOf(JSSyntax.Literal(type: .Literal, value: oneOf(1.2), raw: "1.2"))))))))))
            ], sourceType: "script"))

        }
    }

}


