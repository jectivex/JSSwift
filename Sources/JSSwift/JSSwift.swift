import JXKit
import Foundation

/// A tokenizer and parser for JavaScript, based on [Esprima](https://esprima.org).
///
/// Performs lexical analysis (tokenization) or syntactic analysis (parsing) of a JavaScript program.
///
/// See also: `JXContext.installJavaScriptParser`
open class JavaScriptParser {
    open var ctx: JXContext
    public let esprimaVersion: String?

    let esprima: JXValue

    let tokenizeFunction: JXValue
    let parseScriptFunction: JXValue
    let parseModuleFunction: JXValue

    public init(ctx: JXContext = JXContext()) throws {
        self.ctx = ctx

        try ctx.installJavaScriptParser()


        func check(_ value: JXValue, isFunction shouldBeFunction: Bool) throws -> JXValue {
            if !value.isObject {
                throw Errors.valueNotObject
            }
            if shouldBeFunction && !value.isFunction {
                throw Errors.valueNotFunction
            }
            return value
        }


        self.esprima = try check(ctx["exports"]["esprima"], isFunction: false)
        self.esprimaVersion = esprima["version"].stringValue
        self.tokenizeFunction = try check(esprima["tokenize"], isFunction: true)
        self.parseScriptFunction = try check(esprima["parseScript"], isFunction: true)
        self.parseModuleFunction = try check(esprima["parseModule"], isFunction: true)
    }

    public enum Errors : Error {
        case valueNotObject
        case valueNotFunction
    }

    deinit {

    }

    /// Tokenizes the given JavaScript with options. This takes a string as an input and produces an array of tokens, a list of object representing categorized input characters.
    ///
    /// More info: [Lexical Analysis](https://esprima.readthedocs.io/en/4.0/lexical-analysis.html)
    ///
    /// - Parameters:
    ///   - javaScript: the JavaScript string to tokenize
    ///   - options: the tokenization options, such as whether to include source locations in the tokens
    /// - Returns: the list of tokens
    /// - SeeAlso: `JavaScriptParser.parse`
    open func tokenize(javaScript: String, options: TokenizeOptions = .init()) throws -> [JSToken] {
        return try ctx.trying { // invoke the cached function with the encoded arguments
            try tokenizeFunction.call(withArguments: [ctx.string(javaScript), ctx.encode(options)])

        }.toDecodable(ofType: [JSToken].self)
    }

    /// Options for `JavaScriptParser.tokenize`
    ///
    /// See also: [parseScript/parseModule](https://esprima.readthedocs.io/en/4.0/lexical-analysis.html#chapter-3-lexical-analysis-tokenization)
    public struct TokenizeOptions : Encodable {
        /// Annotate each token with its zero-based start and end location
        ///
        /// Default value: `false`
        public var range: Bool?

        /// Annotate each token with its column and row-based location
        ///
        /// Default value: `false`
        public var loc: Bool?

        /// Include every line and block comment in the output
        ///
        /// Default value: `false`
        public var comment: Bool?

        public init(range: Bool? = nil, loc: Bool? = nil, comment: Bool? = nil) {
            self.range = range
            self.loc = loc
            self.comment = comment
        }
    }

    /// Parses a JavaScript script.
    ///
    /// More info: [Syntactic Analysis](https://esprima.readthedocs.io/en/4.0/syntactic-analysis.html)
    open func parse(script javaScript: String, options: ParseOptions = .init()) throws -> JSSyntax.Script {
        return try ctx.trying { // invoke the cached function with the encoded arguments
            parseScriptFunction.call(withArguments: [ctx.string(javaScript), try ctx.encode(options)])
        }.toDecodable(ofType: JSSyntax.Script.self)
    }

    /// Parses a JavaScript module.
    /// 
    /// This differs from `parse(script:)` in that it permits module syntax like imports.
    ///
    /// More info: [Syntactic Analysis](https://esprima.readthedocs.io/en/4.0/syntactic-analysis.html)
    open func parse(module javaScript: String, options: ParseOptions = .init()) throws -> JSSyntax.Module {
        return try ctx.trying { // invoke the cached function with the encoded arguments
            parseModuleFunction.call(withArguments: [ctx.string(javaScript), try ctx.encode(options)])
        }.toDecodable(ofType: JSSyntax.Module.self)
    }

    /// Options for `JavaScriptParser.parse`
    ///
    /// See also: [parseScript/parseModule](https://esprima.readthedocs.io/en/4.0/syntactic-analysis.html#chapter-2-syntactic-analysis-parsing)
    public struct ParseOptions : Encodable {
        /// Whether the parser should include the range.
        ///
        /// Default value: `false`
        public var range: Bool?

        /// Whether the parser should include the source location
        ///
        /// Default value: `false`
        public var loc: Bool?

        /// Tolerate a few cases of syntax errors
        ///
        /// Default value: `false`
        public var tolerant: Bool?

        /// Collect every token
        ///
        /// Default value: `false`
        public var tokens: Bool?

        /// Collect every line and block comment
        ///
        /// Default value: `false`
        public var comment: Bool?

        public init(range: Bool? = nil, loc: Bool? = nil, tolerant: Bool? = nil, tokens: Bool? = nil, comment: Bool? = nil) {
            self.range = range
            self.loc = loc
            self.tolerant = tolerant
            self.tokens = tokens
            self.comment = comment
        }

    }

}

extension JXContext {
    @available(*, deprecated, message: "use installJavaScriptParser instead")
    public static let SwiftJSResourceURL = Bundle.module.url(forResource: "esprima", withExtension: "js", subdirectory: "Resources/JavaScript")

    /// Installs the `esprima.js` JavaScript parser into `exports.esprima`
    @discardableResult public func installJavaScriptParser() throws -> JXValType {
        let exports = self.globalObject(property: "exports")
        let esprimaProp = "esprima" // this is hardwired by `esprima.js`, so there's no point in customizing it
        if exports[esprimaProp].isObject == false {
            let _ = try installModule(named: "esprima", in: .module)
        }
        let esprima = exports[esprimaProp] // esprima installs itself into the literal "exports", so fetch it from there
        if esprima.isObject == false {
            throw Errors.evaluationError(esprima)
        }
        return esprima
    }
}
