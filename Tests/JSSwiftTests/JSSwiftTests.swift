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

        defer {
            XCTAssertEqual(0, JXDebugContext.debugContextCount, "context did not deinit")
        }

        do {
            let ctx = JXDebugContext()
            XCTAssertEqual(1, JXDebugContext.debugContextCount)

            let esprima = try ctx.installEsprima()
            debugPrint("installed", esprima)
            XCTAssertTrue(esprima.isObject)
            let tokenize = esprima["tokenize"]
            XCTAssertTrue(tokenize.isFunction)

            func expect(js javaScript: String, tokenTypes: [JSTokenType], line: UInt = #line) throws {
                let tokenized = try ctx.trying { tokenize.call(withArguments: [ctx.string(javaScript)]) }

                //print("received", try! tokenized.toJSON(indent: 2))
                let tokenList = try tokenized.toDecodable(ofType: [JSToken].self)
                //print("tokens", tokens)

                XCTAssertEqual(tokenTypes, tokenList.map(\.type), line: line)
            }

            try expect(js: "1+2", tokenTypes: [.NumericLiteral, .Punctuator, .NumericLiteral])
        }
    }

//    func testEsprimaParser() throws {
//        let parser = try EsprimaParser()
//
//        do {
//            let parsed = try parser.parse("1.1")
//            //dbg(parsed)
//
//            guard let script: EsprimaASTNode.Script = parsed.infer() else {
//                return XCTFail("not a script node")
//            }
//            XCTAssertEqual(1, script.body.count)
//            if let decstmnt: EsprimaASTNode.StatementListItem = script.body.first {
//                XCTAssertEqual("ExpressionStatement", decstmnt.typeName)
//                guard let estmnt: EsprimaASTNode.ExpressionStatement = decstmnt.infer()?.infer()?.infer() else {
//                    return XCTFail("not a statement")
//                }
//                XCTAssertEqual("Literal", estmnt.expression.typeName)
//                guard let literal: EsprimaASTNode.Literal = estmnt.expression.infer()?.infer() else {
//                    return XCTFail("not a literal")
//                }
//                XCTAssertEqual(literal.raw, "1.1")
//                XCTAssertEqual(literal.value.infer(), 1.1)
//                //decstmnt[routing: (\.self, \.self)]
//            }
//
//        }
//
//        do {
//            let parsed = try parser.parse("const answer = 42")
//            //dbg(parsed)
//
//            guard let _: EsprimaASTNode.Script = parsed.infer() else {
//                return XCTFail("not a script node")
//            }
//        }
//
//        do {
//            let tokenized = parser.tokenize("const answer = 42")
//            //dbg(tokens)
//
//            XCTAssertEqual(4, tokenized.tokens.count)
//
//            XCTAssertEqual([.Keyword, .Identifier, .Punctuator, .NumericLiteral], tokenized.tokens.map(\.type))
//
//            XCTAssertEqual([0...5, 6...12, 13...14, 15...17], tokenized.tokens.compactMap(\.range))
//        }
//
//        do {
//            // esprima, tokenize thyself…
//            let script = try parser.url.loadString() // 277 KB -> JSON 1.5 MB
//
//            measure {
//                // locations on: [Time, seconds] average: 0.658, relative standard deviation: 5.149%, values: [0.756220, 0.663784, 0.661131, 0.652748, 0.642680, 0.649278, 0.640596, 0.642016, 0.638414, 0.635282]
//                // locations off: [Time, seconds] average: 0.461, relative standard deviation: 4.318%, values: [0.520203, 0.456917, 0.458185, 0.459446, 0.455782, 0.448329, 0.452924, 0.448931, 0.458376, 0.455171]
//                let tokenized = parser.tokenize(script)
//                XCTAssertEqual(43_543, tokenized.tokens.count)
//            }
//        }
//
//        if this(false) { // not yet working
//            // esprima, parse thyself…
//            let script = try parser.url.loadString()
//            let parsed = try parser.parse(script)
//            dbg(parsed)
//        }
//
//    }


}


