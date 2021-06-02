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

            XCTAssertEqual("4.0.1", parser.esprimaVersion)

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

            /// Checks that the given JavaScript script or module can be parsed
            func parse(js javaScript: String, tokenTypes: [JSTokenType]? = nil, module: Bool = false, tolerant: Bool = false, debug: Bool = false, expect: OneOf<JSSyntax.Script>.Or<JSSyntax.Module>? = nil, line: UInt = #line) throws {
                var opts = popts
                opts.tolerant = tolerant
                if debug {
                    opts.loc = false
                    opts.range = false
                    let raw = try parser.parseScriptFunction.call(withArguments: [parser.ctx.string(javaScript), parser.ctx.encode(opts)])
                    print(try raw.toJSON(indent: 2))
                }

                if module {
                    let module = try parser.parse(module: javaScript, options: opts)
                    if let expectModule = expect {
                        XCTAssertEqual(oneOf(module), expectModule, line: line)
                    }
                } else {
                    let script = try parser.parse(script: javaScript, options: opts)
                    if let expectScript = expect {
                        XCTAssertEqual(oneOf(script), expectScript, line: line)
                    }
                }
            }

            do { // demonstrate the difference between parsing a script and a module
                let js = "export const answer = 42"
                XCTAssertThrowsError(try parse(js: js, module: false))
                XCTAssertNoThrow(try parse(js: js, module: true))
            }

            try parse(js: "true")
            try parse(js: "false")
            try parse(js: "true")
            try parse(js: "[]")
            try parse(js: "1")
            try parse(js: "1.1")
            try parse(js: "1.01")
            try parse(js: "function doSomething() { return 1 + 'abx'; }")
            try parse(js: "function doSomething() { abc(); }")

            try parse(js: "[]")
            try parse(js: "{}")

            try parse(js: "{[[0]]}")

            try parse(js: "{{}}")
            try parse(js: "function doSomething() { { } }")

            try parse(js: "for (let i = 0; i < 10; i++) { }")

            try parse(js: "function doSomething() { for (var i = 0; i < 10; i++) { } }")
            try parse(js: "function allTypes() { return { }; }")
            try parse(js: "function allTypes() { return { a: 1.2 }; }")
            try parse(js: "function allTypes() { return { a: 1.2, 'b': null, \"c\": [true, false] }; }")

            try parse(js: "for (const x in list) process(x);")

            try parse(js: "class A {static [\"prototype\"](){}}")


            guard let url = JXContext.SwiftJSResourceURL else {
                return XCTFail("no resource URL")
            }

            let scriptString = try String(contentsOf: url)
            let _ = try parser.parse(script: scriptString) // make sure we can parse the script once
            measure { // then profile the script parsing
                do {
                    let _ = try parser.parse(module: scriptString)
                } catch {
                    XCTFail("error measuring performance: \(error)")
                }
            }

            /// AST examples

//            try parse(js: "const answer = 42", module: false, expect: oneOf(JSSyntax.Script(body: [
//                .init(.init(JSSyntax.VariableDeclaration(declarations: [
//                    JSSyntax.VariableDeclarator(id: oneOf(JSSyntax.Identifier(name: "answer")), init: oneOf(oneOf(oneOf(JSSyntax.Literal(value: oneOf(42.0), raw: "42")))))
//                ], kind: "const")))
//            ], sourceType: "script")))
//
//
//            try parse(js: "const answer = 42", module: true, expect: oneOf(JSSyntax.Module(body: [
//                .init(.init(.init(JSSyntax.VariableDeclaration(declarations: [
//                    JSSyntax.VariableDeclarator(id: oneOf(JSSyntax.Identifier(name: "answer")), init: oneOf(oneOf(oneOf(JSSyntax.Literal(value: oneOf(42.0), raw: "42")))))
//                ], kind: "const"))))
//            ], sourceType: "module")))
//
//
//            try parse(js: "1.2 + 'ABC'", expect: oneOf(JSSyntax.Script(body: [
//                JSSyntax.StatementListItem(JSSyntax.Statement(oneOf(JSSyntax.ExpressionStatement(expression: JSSyntax.Expression(oneOf(JSSyntax.BinaryExpression(operator: "+", left: oneOf(oneOf(JSSyntax.Literal(value: oneOf(1.2), raw: "1.2"))), right: oneOf(oneOf(JSSyntax.Literal(value: oneOf("ABC"), raw: "'ABC'"))))))))))
//            ], sourceType: "script")))
//
//
//            try parse(js: "'XYZ'+1.2", expect: oneOf(JSSyntax.Script(body: [
//                JSSyntax.StatementListItem(JSSyntax.Statement(oneOf(JSSyntax.ExpressionStatement(expression: JSSyntax.Expression(oneOf(JSSyntax.BinaryExpression(operator: "+", left: oneOf(oneOf(JSSyntax.Literal(value: oneOf("XYZ"), raw: "'XYZ'"))), right: oneOf(oneOf(JSSyntax.Literal(value: oneOf(1.2), raw: "1.2"))))))))))
//            ], sourceType: "script")))

        }
    }


    func testParseEsprimaTrees() {
        let treeFiles = """
            """
        // /opt/src/github/esprima/test/fixtures/directive-prolog/migrated_0000.tree.json

        for file in treeFiles.split(separator: "\n") {
            do {
                //print("parsing file:", file)
                let _ = try JSSyntax.Script.loadJSON(url: URL(fileURLWithPath: String(file)))
            } catch {
                XCTFail("error parsing \(file)") // ": \(error)")
            }
        }
    }

}

