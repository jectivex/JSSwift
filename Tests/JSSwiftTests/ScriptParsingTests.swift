import XCTest
import JSSwift

final class ScriptParsingTests : XCTestCase {
    /// Cached script parser result
    let sharedParser = Result { try JavaScriptParser() }

    func parseLibrary(path: String, tokenizeOnly: Bool?, bric: Bool?, debug: Bool = false) throws {
        guard let syntaxURL = Bundle.module.url(forResource: path, withExtension: "json", subdirectory: "TestResources/parser/syntax") else {
            return XCTFail("no JSON resource for \(path)")
        }

        guard let tokensURL = Bundle.module.url(forResource: path, withExtension: "tokens", subdirectory: "TestResources/parser/syntax") else {
            return XCTFail("no tokens resource for \(path)")
        }

        // attempt to parse the tokens
        let expectedTokens = try [JSToken].loadJSON(url: tokensURL)

        guard let scriptURL = Bundle.module.url(forResource: path, withExtension: "js", subdirectory: "TestResources/parser") else {
            return XCTFail("no JS resource for \(path)")
        }

        if tokenizeOnly == true {
            let tokens = try sharedParser.get().tokenize(javaScript: String(contentsOf: scriptURL), options: .init(range: true))

            XCTAssertFalse(tokens.isEmpty, "no tokens in \(path)")
            if tokenizeOnly != nil && tokens != expectedTokens {
                if debug {
                    for (index, (t1, t2)) in zip(tokens, expectedTokens).enumerated() {
                        if t1 != t2 {
                            print("mismatch in token #\(index):\n    \(t1)\n    \(t2)")
                        }
                    }
                }

                XCTFail("tokens mismatch in \(path)")
            }
        } else if bric == nil { // parse as raw JSON
            let script: JSSyntax.Script = try sharedParser.get().parseJSON(script: String(contentsOf: scriptURL), options: .init(range: true, loc: true))
            XCTAssertFalse(script.body.isEmpty)
        } else if bric == true {
            let bric = try sharedParser.get().parseBric(script: String(contentsOf: scriptURL), options: .init(range: true, loc: true))

            // attempt to parse the syntax
            let expectedBric = try Bric.loadJSON(url: syntaxURL)

            if tokenizeOnly != nil && bric != expectedBric {
                XCTFail("bric mismatch in \(path)")
            }
        } else {
            let syntax = try sharedParser.get().parseJSSyntax(script: String(contentsOf: scriptURL), options: .init(range: true, loc: true))

            // attempt to parse the syntax
            let expectedSyntax = try JSSyntax.Script.loadJSON(url: syntaxURL)

            if tokenizeOnly != nil && syntax != expectedSyntax {
                XCTFail("syntax mismatch in \(path)")
            }

            // avoid XCTAssertEqual, since it prints out the massive OneOf debug descriptions
            // XCTAssertEqual(expectedSyntax, actualSyntax, "syntax mismatch")
            if tokenizeOnly != nil && syntax != expectedSyntax {
                XCTFail("syntax mismatch in \(path)")
            }
        }
    }

    func testParseAngular() throws {
        try parseLibrary(path: "angular-1.2.5", tokenizeOnly: false, bric: false)
    }

    func testParseAngularJSON() throws {
        try parseLibrary(path: "angular-1.2.5", tokenizeOnly: false, bric: nil)
    }

    func testParseAngularBric() throws {
        try parseLibrary(path: "angular-1.2.5", tokenizeOnly: false, bric: true)
    }

    func testTokenizeAngular() throws {
        try parseLibrary(path: "angular-1.2.5", tokenizeOnly: true, bric: false)
    }

    func testParseJQuery() throws {
        throw XCTSkip("jquery-1.9.1 is known to mismatch")
        try parseLibrary(path: "jquery-1.9.1", tokenizeOnly: false, bric: false)
    }

    func testParseJQueryJSON() throws {
        try parseLibrary(path: "jquery-1.9.1", tokenizeOnly: false, bric: nil)
    }

    func testParseJQueryBric() throws {
        throw XCTSkip("jquery-1.9.1 is known to mismatch")
        try parseLibrary(path: "jquery-1.9.1", tokenizeOnly: false, bric: true)
    }

    func testTokenizeJQuery() throws {
        try parseLibrary(path: "jquery-1.9.1", tokenizeOnly: true, bric: false)
    }

    func testParseBackbone() throws {
        try parseLibrary(path: "backbone-1.1.0", tokenizeOnly: false, bric: false)
    }

    func testParseBackboneJSON() throws {
        try parseLibrary(path: "backbone-1.1.0", tokenizeOnly: false, bric: nil)
    }

    func testParseBackboneBric() throws {
        try parseLibrary(path: "backbone-1.1.0", tokenizeOnly: false, bric: true)
    }

    func testTokenizeBackbone() throws {
        try parseLibrary(path: "backbone-1.1.0", tokenizeOnly: true, bric: false)
    }

    func testParseJQueryMobile() throws {
        try parseLibrary(path: "jquery.mobile-1.4.2", tokenizeOnly: false, bric: false)
    }

    func testParseJQueryMobileJSON() throws {
        try parseLibrary(path: "jquery.mobile-1.4.2", tokenizeOnly: false, bric: nil)
    }

    func testParseJQueryMobileBric() throws {
        try parseLibrary(path: "jquery.mobile-1.4.2", tokenizeOnly: false, bric: true)
    }

    func testTokenizeJQueryMobile() throws {
        try parseLibrary(path: "jquery.mobile-1.4.2", tokenizeOnly: true, bric: false)
    }

    func testParseUnderscore() throws {
        try parseLibrary(path: "underscore-1.5.2", tokenizeOnly: false, bric: false)
    }

    func testParseUnderscoreJSON() throws {
        try parseLibrary(path: "underscore-1.5.2", tokenizeOnly: false, bric: nil)
    }

    func testParseUnderscoreBric() throws {
        try parseLibrary(path: "underscore-1.5.2", tokenizeOnly: false, bric: true)
    }

    func testTokenizeUnderscore() throws {
        try parseLibrary(path: "underscore-1.5.2", tokenizeOnly: true, bric: false)
    }

    func testParseMooTools() throws {
        try parseLibrary(path: "mootools-1.4.5", tokenizeOnly: false, bric: false)
    }

    func testParseMooToolsJSON() throws {
        try parseLibrary(path: "mootools-1.4.5", tokenizeOnly: false, bric: nil)
    }

    func testParseMooToolsBric() throws {
        try parseLibrary(path: "mootools-1.4.5", tokenizeOnly: false, bric: true)
    }

    func testTokenizeMooTools() throws {
        try parseLibrary(path: "mootools-1.4.5", tokenizeOnly: true, bric: false)
    }

    func testParseYUI() throws {
        try parseLibrary(path: "yui-3.12.0", tokenizeOnly: false, bric: false)
    }

    func testParseYUIJSON() throws {
        try parseLibrary(path: "yui-3.12.0", tokenizeOnly: false, bric: nil)
    }

    func testParseYUIBric() throws {
        try parseLibrary(path: "yui-3.12.0", tokenizeOnly: false, bric: true)
    }

    func testTokenizeYUI() throws {
        try parseLibrary(path: "yui-3.12.0", tokenizeOnly: true, bric: false)
    }
}


private extension JavaScriptParser {
    /// Parses a source into a JS tree
    func parseJSON<T: Decodable>(script javaScript: String, indent: UInt32 = 0, options: ParseOptions = .init()) throws -> T {
        return try ctx.trying { // invoke the cached function with the encoded arguments
            parseScriptFunction.call(withArguments: [ctx.string(javaScript), try ctx.encode(options)])
        }.toDecodable(ofType: T.self)
    }
}

private extension JXValue {
    /// Decodes the value by first serializing it to a String
    func toJSONDecodable<T: Decodable>(ofType: T.Type) throws -> T {
        // try JXValueDecoder(context: env).decode(ofType, from: self)
        try T.loadFromJSON(data: toJSON(indent: 0).data(using: .utf8) ?? Data())
    }
}
