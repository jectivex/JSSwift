
// A JavaScript AST, translated from esprima's `syntax.ts`

import Foundation

// MARK: syntax.ts

enum Syntax {
    enum AssignmentExpression : String, Codable { case AssignmentExpression = "AssignmentExpression" }
    enum AssignmentPattern  : String, Codable { case AssignmentPattern = "AssignmentPattern" }
    enum ArrayExpression : String, Codable { case ArrayExpression = "ArrayExpression" }
    enum ArrayPattern : String, Codable { case ArrayPattern = "ArrayPattern" }
    enum ArrowFunctionExpression : String, Codable { case ArrowFunctionExpression = "ArrowFunctionExpression" }
    enum AwaitExpression : String, Codable { case AwaitExpression = "AwaitExpression" }
    enum BlockStatement : String, Codable { case BlockStatement = "BlockStatement" }
    enum BinaryExpression : String, Codable { case BinaryExpression = "BinaryExpression" }
    enum BreakStatement : String, Codable { case BreakStatement = "BreakStatement" }
    enum CallExpression : String, Codable { case CallExpression = "CallExpression" }
    enum CatchClause : String, Codable { case CatchClause = "CatchClause" }
    enum ClassBody : String, Codable { case ClassBody = "ClassBody" }
    enum ClassDeclaration : String, Codable { case ClassDeclaration = "ClassDeclaration" }
    enum ClassExpression : String, Codable { case ClassExpression = "ClassExpression" }
    enum ConditionalExpression : String, Codable { case ConditionalExpression = "ConditionalExpression" }
    enum ContinueStatement : String, Codable { case ContinueStatement = "ContinueStatement" }
    enum DoWhileStatement : String, Codable { case DoWhileStatement = "DoWhileStatement" }
    enum DebuggerStatement : String, Codable { case DebuggerStatement = "DebuggerStatement" }
    enum EmptyStatement : String, Codable { case EmptyStatement = "EmptyStatement" }
    enum ExportAllDeclaration : String, Codable { case ExportAllDeclaration = "ExportAllDeclaration" }
    enum ExportDefaultDeclaration : String, Codable { case ExportDefaultDeclaration = "ExportDefaultDeclaration" }
    enum ExportNamedDeclaration : String, Codable { case ExportNamedDeclaration = "ExportNamedDeclaration" }
    enum ExportSpecifier : String, Codable { case ExportSpecifier = "ExportSpecifier" }
    enum ExpressionStatement : String, Codable { case ExpressionStatement = "ExpressionStatement" }
    enum ForStatement : String, Codable { case ForStatement = "ForStatement" }
    enum ForOfStatement : String, Codable { case ForOfStatement = "ForOfStatement" }
    enum ForInStatement : String, Codable { case ForInStatement = "ForInStatement" }
    enum FunctionDeclaration : String, Codable { case FunctionDeclaration = "FunctionDeclaration" }
    enum FunctionExpression : String, Codable { case FunctionExpression = "FunctionExpression" }
    enum Identifier : String, Codable { case Identifier = "Identifier" }
    enum IfStatement : String, Codable { case IfStatement = "IfStatement" }
    enum Import : String, Codable { case Import = "Import" }
    enum ImportDeclaration : String, Codable { case ImportDeclaration = "ImportDeclaration" }
    enum ImportDefaultSpecifier : String, Codable { case ImportDefaultSpecifier = "ImportDefaultSpecifier" }
    enum ImportNamespaceSpecifier : String, Codable { case ImportNamespaceSpecifier = "ImportNamespaceSpecifier" }
    enum ImportSpecifier : String, Codable { case ImportSpecifier = "ImportSpecifier" }
    enum Literal : String, Codable { case Literal = "Literal" }
    enum LabeledStatement : String, Codable { case LabeledStatement = "LabeledStatement" }
    enum LogicalExpression : String, Codable { case LogicalExpression = "LogicalExpression" }
    enum MemberExpression : String, Codable { case MemberExpression = "MemberExpression" }
    enum MetaProperty : String, Codable { case MetaProperty = "MetaProperty" }
    enum MethodDefinition : String, Codable { case MethodDefinition = "MethodDefinition" }
    enum NewExpression : String, Codable { case NewExpression = "NewExpression" }
    enum ObjectExpression : String, Codable { case ObjectExpression = "ObjectExpression" }
    enum ObjectPattern : String, Codable { case ObjectPattern = "ObjectPattern" }
    enum Program : String, Codable { case Program = "Program" }
    enum Property : String, Codable { case Property = "Property" }
    enum RestElement : String, Codable { case RestElement = "RestElement" }
    enum ReturnStatement : String, Codable { case ReturnStatement = "ReturnStatement" }
    enum SequenceExpression : String, Codable { case SequenceExpression = "SequenceExpression" }
    enum SpreadElement : String, Codable { case SpreadElement = "SpreadElement" }
    enum Super : String, Codable { case Super = "Super" }
    enum SwitchCase : String, Codable { case SwitchCase = "SwitchCase" }
    enum SwitchStatement : String, Codable { case SwitchStatement = "SwitchStatement" }
    enum TaggedTemplateExpression : String, Codable { case TaggedTemplateExpression = "TaggedTemplateExpression" }
    enum TemplateElement : String, Codable { case TemplateElement = "TemplateElement" }
    enum TemplateLiteral : String, Codable { case TemplateLiteral = "TemplateLiteral" }
    enum ThisExpression : String, Codable { case ThisExpression = "ThisExpression" }
    enum ThrowStatement : String, Codable { case ThrowStatement = "ThrowStatement" }
    enum TryStatement : String, Codable { case TryStatement = "TryStatement" }
    enum UnaryExpression : String, Codable { case UnaryExpression = "UnaryExpression" }
    enum UpdateExpression : String, Codable { case UpdateExpression = "UpdateExpression" }
    enum VariableDeclaration : String, Codable { case VariableDeclaration = "VariableDeclaration" }
    enum VariableDeclarator : String, Codable { case VariableDeclarator = "VariableDeclarator" }
    enum WhileStatement : String, Codable { case WhileStatement = "WhileStatement" }
    enum WithStatement : String, Codable { case WithStatement = "WithStatement" }
    enum YieldExpression : String, Codable { case YieldExpression = "YieldExpressio" }
}


// - MARK: messages.ts

public enum Messages {
    case BadImportCallArity
    case BadGetterArity
    case BadSetterArity
    case BadSetterRestParameter
    case ConstructorIsAsync
    case ConstructorSpecialMethod
    case DeclarationMissingInitializer
    case DefaultRestParameter
    case DefaultRestProperty
    case DuplicateBinding
    case DuplicateConstructor
    case DuplicateProtoProperty
    case ForInOfLoopInitializer
    case GeneratorInLegacyContext
    case IllegalBreak
    case IllegalContinue
    case IllegalExportDeclaration
    case IllegalImportDeclaration
    case IllegalLanguageModeDirective
    case IllegalReturn
    case InvalidEscapedReservedWord
    case InvalidHexEscapeSequence
    case InvalidLHSInAssignment
    case InvalidLHSInForIn
    case InvalidLHSInForLoop
    case InvalidModuleSpecifier
    case InvalidRegExp
    case LetInLexicalBinding
    case MissingFromClause
    case MultipleDefaultsInSwitch
    case NewlineAfterThrow
    case NoAsAfterImportNamespace
    case NoCatchOrFinally
    case ParameterAfterRestParameter
    case PropertyAfterRestProperty
    case Redeclaration
    case StaticPrototype
    case StrictCatchVariable
    case StrictDelete
    case StrictFunction
    case StrictFunctionName
    case StrictLHSAssignment
    case StrictLHSPostfix
    case StrictLHSPrefix
    case StrictModeWith
    case StrictOctalLiteral
    case StrictParamDupe
    case StrictParamName
    case StrictReservedWord
    case StrictVarName
    case TemplateOctalLiteral
    case UnexpectedEOS
    case UnexpectedIdentifier
    case UnexpectedNumber
    case UnexpectedReserved
    case UnexpectedString
    case UnexpectedTemplate
    case UnexpectedToken
    case UnexpectedTokenIllegal
    case UnknownLabel
    case UnterminatedRegExp

    /// Error messages should be identical to V8.
    var errorDescription: String {
        switch self {
        case .BadImportCallArity: return "Unexpected token"
        case .BadGetterArity: return "Getter must not have any formal parameters"
        case .BadSetterArity: return "Setter must have exactly one formal parameter"
        case .BadSetterRestParameter: return "Setter function argument must not be a rest parameter"
        case .ConstructorIsAsync: return "Class constructor may not be an async method"
        case .ConstructorSpecialMethod: return "Class constructor may not be an accessor"
        case .DeclarationMissingInitializer: return "Missing initializer in %0 declaration"
        case .DefaultRestParameter: return "Unexpected token ="
        case .DefaultRestProperty: return "Unexpected token ="
        case .DuplicateBinding: return "Duplicate binding %0"
        case .DuplicateConstructor: return "A class may only have one constructor"
        case .DuplicateProtoProperty: return "Duplicate __proto__ fields are not allowed in object literals"
        case .ForInOfLoopInitializer: return "%0 loop variable declaration may not have an initializer"
        case .GeneratorInLegacyContext: return "Generator declarations are not allowed in legacy contexts"
        case .IllegalBreak: return "Illegal break statement"
        case .IllegalContinue: return "Illegal continue statement"
        case .IllegalExportDeclaration: return "Unexpected token"
        case .IllegalImportDeclaration: return "Unexpected token"
        case .IllegalLanguageModeDirective: return "Illegal 'use strict' directive in function with non-simple parameter list"
        case .IllegalReturn: return "Illegal return statement"
        case .InvalidEscapedReservedWord: return "Keyword must not contain escaped characters"
        case .InvalidHexEscapeSequence: return "Invalid hexadecimal escape sequence"
        case .InvalidLHSInAssignment: return "Invalid left-hand side in assignment"
        case .InvalidLHSInForIn: return "Invalid left-hand side in for-in"
        case .InvalidLHSInForLoop: return "Invalid left-hand side in for-loop"
        case .InvalidModuleSpecifier: return "Unexpected token"
        case .InvalidRegExp: return "Invalid regular expression"
        case .LetInLexicalBinding: return "let is disallowed as a lexically bound name"
        case .MissingFromClause: return "Unexpected token"
        case .MultipleDefaultsInSwitch: return "More than one default clause in switch statement"
        case .NewlineAfterThrow: return "Illegal newline after throw"
        case .NoAsAfterImportNamespace: return "Unexpected token"
        case .NoCatchOrFinally: return "Missing catch or finally after try"
        case .ParameterAfterRestParameter: return "Rest parameter must be last formal parameter"
        case .PropertyAfterRestProperty: return "Unexpected token"
        case .Redeclaration: return "%0 '%1' has already been declared"
        case .StaticPrototype: return "Classes may not have static property named prototype"
        case .StrictCatchVariable: return "Catch variable may not be eval or arguments in strict mode"
        case .StrictDelete: return "Delete of an unqualified identifier in strict mode."
        case .StrictFunction: return "In strict mode code, functions can only be declared at top level or inside a block"
        case .StrictFunctionName: return "Function name may not be eval or arguments in strict mode"
        case .StrictLHSAssignment: return "Assignment to eval or arguments is not allowed in strict mode"
        case .StrictLHSPostfix: return "Postfix increment/decrement may not have eval or arguments operand in strict mode"
        case .StrictLHSPrefix: return "Prefix increment/decrement may not have eval or arguments operand in strict mode"
        case .StrictModeWith: return "Strict mode code may not include a with statement"
        case .StrictOctalLiteral: return "Octal literals are not allowed in strict mode."
        case .StrictParamDupe: return "Strict mode function may not have duplicate parameter names"
        case .StrictParamName: return "Parameter name eval or arguments is not allowed in strict mode"
        case .StrictReservedWord: return "Use of future reserved word in strict mode"
        case .StrictVarName: return "Variable name may not be eval or arguments in strict mode"
        case .TemplateOctalLiteral: return "Octal literals are not allowed in template strings."
        case .UnexpectedEOS: return "Unexpected end of input"
        case .UnexpectedIdentifier: return "Unexpected identifier"
        case .UnexpectedNumber: return "Unexpected number"
        case .UnexpectedReserved: return "Unexpected reserved word"
        case .UnexpectedString: return "Unexpected string"
        case .UnexpectedTemplate: return "Unexpected quasi %0"
        case .UnexpectedToken: return "Unexpected token %0"
        case .UnexpectedTokenIllegal: return "Unexpected token ILLEGAL"
        case .UnknownLabel: return "Undefined label '%0'"
        case .UnterminatedRegExp: return "Invalid regular expression: missing /"
        }
    }
}


// MARK: token.ts

typealias Token = JSTokenType

public enum JSTokenType : String, Hashable, Codable {
    case BooleanLiteral = "Boolean"
    case EOF = "<end>"
    case Identifier = "Identifier"
    case Keyword = "Keyword"
    case NullLiteral = "Null"
    case NumericLiteral = "Numeric"
    case Punctuator = "Punctuator"
    case StringLiteral = "String"
    case RegularExpression = "RegularExpression"
    case Template = "Template"
}

let TokenName = [
    Token.BooleanLiteral: "Boolean",
    Token.EOF: "<end>",
    Token.Identifier: "Identifier",
    Token.Keyword: "Keyword",
    Token.NullLiteral: "Null",
    Token.NumericLiteral: "Numeric",
    Token.Punctuator: "Punctuator",
    Token.StringLiteral: "String",
    Token.RegularExpression: "RegularExpression",
    Token.Template: "Template",
]


// MARK: tokenizer.ts

public struct Regex : Hashable, Codable {
    public let pattern: String
    public let flags: String
}

/// A lexical token from a JS program or fragment
public struct JSToken : Hashable, Codable {
    public let type: JSTokenType
    public let value: String
    public let regex: Regex?
    public let range: ClosedRange<Int>?
    public let loc: SourceLocation?
}

typealias BufferEntry = JSToken

struct Config : Hashable, Codable {
    let tolerant: Bool?
    let comment: Bool?
    let range: Bool?
    let loc: Bool?
}


// MARK: error-handler.ts

public struct EsprimaError : Error {
    public private(set) var name: String;
    public private(set) var message: String;
    public private(set) var index: Int;
    public private(set) var lineNumber: Int;
    public private(set) var column: Int;
    public private(set) var description: Messages;
}

class ErrorHandler {
    var errors: [EsprimaError];
    var tolerant: Bool;

    init() {
        self.errors = [];
        self.tolerant = false;
    }

    func recordError(error: EsprimaError) {
        self.errors.append(error);
    }

    func tolerate(error: EsprimaError) throws {
        if (self.tolerant) {
            self.recordError(error: error);
        } else {
            throw error;
        }
    }

    func createError(index: Int, line: Int, col: Int, description: Messages) -> EsprimaError {
        EsprimaError(name: "", message: "Line \(line): \(description)", index: index, lineNumber: line, column: col, description: description)
    }

    func throwError(index: Int, line: Int, col: Int, description: Messages) throws {
        throw self.createError(index: index, line: line, col: col, description: description);
    }

    func tolerateError(index: Int, line: Int, col: Int, description: Messages) throws {
        let error = self.createError(index: index, line: line, col: col, description: description);
        if (self.tolerant) {
            self.recordError(error: error);
        } else {
            throw error;
        }
    }

}


// MARK: scanner.ts

public struct Position : Hashable, Codable {
    public let line: Int?
    public let column: Int?
}

public struct SourceLocation : Hashable, Codable {
    public var start: Position
    public var end: Position
    public var source: String? = nil
}



// - MARK: nodes.ts

public protocol EsprimaASTType : Codable {
    /// The name of the AST Type
    var typeName: String { get }
}

public protocol EsprimaAST : Hashable, EsprimaASTType {
    associatedtype NodeType : RawRepresentable where NodeType.RawValue == String
    var type: NodeType { get }
}

public extension EsprimaAST {
    var typeName: String { type.rawValue }
}

extension Never : EsprimaASTType {
    public var typeName: String { fatalError("never") }
}

extension OneOf2 : EsprimaASTType where T1: EsprimaASTType, T2: EsprimaASTType {
    public var typeName: String { expanded.typeName }
}

extension OneOf3 : EsprimaASTType where T1: EsprimaASTType, T2: EsprimaASTType, T3: EsprimaASTType {
    public var typeName: String { expanded.typeName }
}

extension OneOf4 : EsprimaASTType where T1: EsprimaASTType, T2: EsprimaASTType, T3: EsprimaASTType, T4: EsprimaASTType {
    public var typeName: String { expanded.typeName }
}

extension OneOf5 : EsprimaASTType where T1: EsprimaASTType, T2: EsprimaASTType, T3: EsprimaASTType, T4: EsprimaASTType, T5: EsprimaASTType {
    public var typeName: String { expanded.typeName }
}

extension OneOf6 : EsprimaASTType where T1: EsprimaASTType, T2: EsprimaASTType, T3: EsprimaASTType, T4: EsprimaASTType, T5: EsprimaASTType, T6: EsprimaASTType {
    public var typeName: String { expanded.typeName }
}

extension OneOf7 : EsprimaASTType where T1: EsprimaASTType, T2: EsprimaASTType, T3: EsprimaASTType, T4: EsprimaASTType, T5: EsprimaASTType, T6: EsprimaASTType, T7: EsprimaASTType {
    public var typeName: String { expanded.typeName }
}

extension OneOf8 : EsprimaASTType where T1: EsprimaASTType, T2: EsprimaASTType, T3: EsprimaASTType, T4: EsprimaASTType, T5: EsprimaASTType, T6: EsprimaASTType, T7: EsprimaASTType, T8: EsprimaASTType {
    public var typeName: String { expanded.typeName }
}

extension OneOf9 : EsprimaASTType where T1: EsprimaASTType, T2: EsprimaASTType, T3: EsprimaASTType, T4: EsprimaASTType, T5: EsprimaASTType, T6: EsprimaASTType, T7: EsprimaASTType, T8: EsprimaASTType, T9: EsprimaASTType {
    public var typeName: String { expanded.typeName }
}

extension OneOf10 : EsprimaASTType where T1: EsprimaASTType, T2: EsprimaASTType, T3: EsprimaASTType, T4: EsprimaASTType, T5: EsprimaASTType, T6: EsprimaASTType, T7: EsprimaASTType, T8: EsprimaASTType, T9: EsprimaASTType, T10: EsprimaASTType {
    public var typeName: String {
        self[routing: (\.typeName, \.typeName, \.typeName, \.typeName, \.typeName, \.typeName, \.typeName, \.typeName, \.typeName, \.typeName)]
    }
}

/// Namespace for nodes corresponding to `Syntax` cases.
public enum JSSyntax {

    public typealias ArgumentListElement = OneOf2<Expression, SpreadElement>
    public typealias ArrayExpressionElement = OneOf3<Expression, SpreadElement, ExplicitNull>
    public typealias ArrayPatternElement = OneOf5<AssignmentPattern, BindingIdentifier, BindingPattern, RestElement, ExplicitNull>
    public typealias BindingPattern = OneOf2<ArrayPattern, ObjectPattern>
    public typealias BindingIdentifier = Identifier
    public typealias Declaration = OneOf6<AsyncFunctionDeclaration, ClassDeclaration, ExportDeclaration, FunctionDeclaration, ImportDeclaration, VariableDeclaration>
    public typealias ExportableDefaultDeclaration = OneOf5<BindingIdentifier, BindingPattern, ClassDeclaration, Expression, FunctionDeclaration>
    public typealias ExportableNamedDeclaration = OneOf4<AsyncFunctionDeclaration, ClassDeclaration, FunctionDeclaration, VariableDeclaration>
    public typealias ExportDeclaration = OneOf3<ExportAllDeclaration, ExportDefaultDeclaration, ExportNamedDeclaration>
    public typealias Expression = OneOf3<OneOf10<ArrayExpression, ArrowFunctionExpression, AssignmentExpression, AsyncArrowFunctionExpression, AsyncFunctionExpression, AwaitExpression, BinaryExpression, CallExpression, ClassExpression, ComputedMemberExpression>, OneOf10<ConditionalExpression, Identifier, FunctionExpression, Literal, NewExpression, ObjectExpression, RegexLiteral, SequenceExpression, StaticMemberExpression, TaggedTemplateExpression>, OneOf4<ThisExpression, UnaryExpression, UpdateExpression, YieldExpression>>
    public typealias FunctionParameter = OneOf3<AssignmentPattern, BindingIdentifier, BindingPattern>
    public typealias ImportDeclarationSpecifier = OneOf3<ImportDefaultSpecifier, ImportNamespaceSpecifier, ImportSpecifier>
    public typealias ObjectExpressionProperty = OneOf2<Property, SpreadElement>
    public typealias ObjectPatternProperty = OneOf2<Property, RestElement>
    public typealias Statement = OneOf2<OneOf10<AsyncFunctionDeclaration, BreakStatement, ContinueStatement, DebuggerStatement, DoWhileStatement, EmptyStatement, ExpressionStatement, Directive, ForStatement, ForInStatement>, OneOf10<ForOfStatement, FunctionDeclaration, IfStatement, ReturnStatement, SwitchStatement, ThrowStatement, TryStatement, VariableDeclaration, WhileStatement, WithStatement>>
    public typealias PropertyKey = OneOf2<Identifier, Literal>
    public typealias PropertyValue = OneOf5<AssignmentPattern, AsyncFunctionExpression, BindingIdentifier, BindingPattern, FunctionExpression>
    public typealias StatementListItem = OneOf2<Declaration, Statement>

    public struct ArrayExpression : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case ArrayExpression }
        public let elements: Array<ArrayExpressionElement>
    }

    public struct ArrayPattern : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case ArrayPattern }
        public let elements: [ArrayPatternElement]
    }

    public struct ArrowFunctionExpression : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case ArrowFunctionExpression }
        public let id: Nullable<Identifier>
        public let params: [FunctionParameter]
        public let body: OneOf2<BlockStatement, Expression>
        public let generator: Bool
        public let expression: Bool
        public let async: Bool

    }

    public struct AssignmentExpression : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case AssignmentExpression}
        public let `operator`: String
        public let left: Expression
        public let right: Expression
    }

    public struct AssignmentPattern : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case AssignmentPattern }
        public let left: OneOf2<BindingIdentifier, BindingPattern>
        public let right: Expression
    }

    public struct AsyncArrowFunctionExpression : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case AsyncArrowFunctionExpression }
        public let id: Nullable<Identifier>
        public let params: [FunctionParameter]
        public let body: OneOf2<BlockStatement, Expression>
        public let generator: Bool
        public let expression: Bool
        public let async: Bool
    }

    public struct AsyncFunctionDeclaration : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case AsyncFunctionDeclaration }
        public let id: Nullable<Identifier>
        public let params: [FunctionParameter]
        public let body: BlockStatement
        public let generator: Bool
        public let expression: Bool
        public let async: Bool
    }

    public struct AsyncFunctionExpression : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case AsyncFunctionExpression }
        public let id: Nullable<Identifier>
        public let params: [FunctionParameter]
        public let body: BlockStatement
        public let generator: Bool
        public let expression: Bool
        public let async: Bool
    }

    public struct AwaitExpression : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case AwaitExpression }
        public let argument: Expression
    }

    public struct BinaryExpression : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case BinaryExpression }
        public let `operator`: String
        public let left: Expression
        public let right: Expression
    }

    public struct BlockStatement : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case BlockStatement }
        public let body: [Statement]

    }

    public struct BreakStatement : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case BreakStatement }
        public let label: Nullable<Identifier>

    }

    public struct CallExpression : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case CallExpression }
        public let callee: OneOf2<Expression, Import>
        public let arguments: [ArgumentListElement]

    }

    public struct CatchClause : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case CatchClause }
        public let param: OneOf2<BindingIdentifier, BindingPattern>
        public let body: BlockStatement

    }

    public struct ClassBody : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case ClassBody }
        public let body: [Property]

    }

    public struct ClassDeclaration : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case ClassDeclaration }
        public let id: Nullable<Identifier>
        public let superClass: Nullable<Identifier>
        public let body: ClassBody

    }

    public struct ClassExpression : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case ClassExpression }
        public let id: Nullable<Identifier>
        public let superClass: Nullable<Identifier>
        public let body: ClassBody

    }

    public struct ComputedMemberExpression : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case ComputedMemberExpression }
        public let computed: Bool
        public let object: Expression
        public let property: Expression

    }

    public struct ConditionalExpression : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case ConditionalExpression }
        public let test: Expression
        public let consequent: Expression
        public let alternate: Expression

    }

    public struct ContinueStatement : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case ContinueStatement }
        public let label: Nullable<Identifier>

    }

    public struct DebuggerStatement : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case DebuggerStatement }

    }

    public struct Directive : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case Directive }
        public let expression: Expression
        public let directive: String

    }

    public struct DoWhileStatement : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case DoWhileStatement }
        public let body: Statement
        public let test: Expression

    }

    public struct EmptyStatement : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case EmptyStatement }

    }

    public struct ExportAllDeclaration : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case ExportAllDeclaration }
        public let source: Literal

    }

    public struct ExportDefaultDeclaration : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case ExportDefaultDeclaration }
        public let declaration: ExportableDefaultDeclaration

    }

    public struct ExportNamedDeclaration : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case ExportNamedDeclaration }
        public let declaration: Nullable<ExportableNamedDeclaration>
        public let specifiers: [ExportSpecifier]
        public let source: Nullable<Literal>

    }

    public struct ExportSpecifier : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case ExportSpecifier }
        public let exported: Identifier
        public let local: Identifier

    }

    public struct ExpressionStatement : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case ExpressionStatement }
        public let expression: Expression

    }

    public struct ForInStatement : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case ForInStatement }
        public let left: Expression
        public let right: Expression
        public let body: Statement
        public let each: Bool

    }

    public struct ForOfStatement : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case ForOfStatement }
        public let left: Expression
        public let right: Expression
        public let body: Statement

    }

    public struct ForStatement : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case ForStatement }
        public let `init`: Nullable<Expression>
        public let test: Nullable<Expression>
        public let update: Nullable<Expression>
        public let body: Statement

    }

    public struct FunctionDeclaration : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case FunctionDeclaration }
        public let id: Nullable<Identifier>
        public let params: [FunctionParameter]
        public let body: BlockStatement
        public let generator: Bool
        public let expression: Bool
        public let async: Bool

    }

    public struct FunctionExpression : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case FunctionExpression }
        public let id: Nullable<Identifier>
        public let params: [FunctionParameter]
        public let body: BlockStatement
        public let generator: Bool
        public let expression: Bool
        public let async: Bool

    }

    public struct Identifier : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case Identifier }
        public let name: String

    }

    public struct IfStatement : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case IfStatement }
        public let test: Expression
        public let consequent: Statement
        public let alternate: Nullable<Statement>

    }

    public struct Import : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case Import }

    }

    public struct ImportDeclaration : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case ImportDeclaration }
        public let specifiers: [ImportDeclarationSpecifier]
        public let source: Literal

    }

    public struct ImportDefaultSpecifier : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case ImportDefaultSpecifier }
        public let local: Identifier

    }

    public struct ImportNamespaceSpecifier : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case ImportNamespaceSpecifier }
        public let local: Identifier

    }

    public struct ImportSpecifier : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case ImportSpecifier }
        public let local: Identifier
        public let imported: Identifier

    }

    public struct LabeledStatement : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case LabeledStatement }
        public let label: Identifier
        public let body: Statement

    }

    public struct Literal : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case Literal }
        public let value: OneOf4<Bool, Double, String, ExplicitNull>
        public let raw: String

    }

    public struct MetaProperty : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case MetaProperty }
        public let meta: Identifier
        public let property: Identifier

    }

    public struct MethodDefinition : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case MethodDefinition }
        public let key: Nullable<Expression>
        public let computed: Bool
        public let value: OneOf3<AsyncFunctionExpression, FunctionExpression, ExplicitNull>
        public let kind: String
        public let `static`: Bool

    }

    public struct Module : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case Module }
        public let body: [StatementListItem]
        public let sourceType: String

    }

    public struct NewExpression : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case NewExpression }
        public let callee: Expression
        public let arguments: [ArgumentListElement]

    }

    public struct ObjectExpression : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case ObjectExpression }
        public let properties: [ObjectExpressionProperty]

    }

    public struct ObjectPattern : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case ObjectPattern }
        public let properties: [ObjectPatternProperty]

    }

    public struct Property : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case Property }
        public let key: PropertyKey
        public let computed: Bool
        public let value: Nullable<PropertyValue>
        public let kind: String
        public let method: Bool
        public let shorthand: Bool

    }

    public struct RegexLiteral : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case RegexLiteral }
        public let value: Bric; // RegExp
        public let raw: String
        public let regex: Regex

    }

    public struct RestElement : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case RestElement }
        public let argument: OneOf2<BindingIdentifier, BindingPattern>

    }

    public struct ReturnStatement : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case ReturnStatement }
        public let argument: Nullable<Expression>

    }

    public struct Script : EsprimaAST {
        public let type: NodeType
        // this was "Script", but the parser seems to want to return "Program"
        public enum NodeType : String, Codable { case Program }
        public let body: [StatementListItem]
        public let sourceType: String

    }

    public struct SequenceExpression : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case SequenceExpression }
        public let expressions: [Expression]

    }

    public struct SpreadElement : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case SpreadElement }
        public let argument: Expression

    }

    public struct StaticMemberExpression : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case StaticMemberExpression }
        public let computed: Bool
        public let object: Expression
        public let property: Expression

    }

    public struct Super : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case Super }

    }

    public struct SwitchCase : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case SwitchCase }
        public let test: Nullable<Expression>
        public let consequent: [Statement]

    }

    public struct SwitchStatement : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case SwitchStatement }
        public let discriminant: Expression
        public let cases: [SwitchCase]

    }

    public struct TaggedTemplateExpression : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case TaggedTemplateExpression }
        public let tag: Expression
        public let quasi: TemplateLiteral

    }

    public struct TemplateElementValue : Hashable, Codable {
        public let cooked: String
        public let raw: String
    }

    public struct TemplateElement : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case TemplateElement }
        public let value: TemplateElementValue
        public let tail: Bool

    }

    public struct TemplateLiteral : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case TemplateLiteral }
        public let quasis: [TemplateElement]
        public let expressions: [Expression]

    }

    public struct ThisExpression : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case ThisExpression }

    }

    public struct ThrowStatement : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case ThrowStatement }
        public let argument: Expression

    }

    public struct TryStatement : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case TryStatement }
        public let block: BlockStatement
        public let handler: Nullable<CatchClause>
        public let finalizer: Nullable<BlockStatement>

    }

    public struct UnaryExpression : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case UnaryExpression }
        public let `operator`: String
        public let argument: Expression
        public let prefix: Bool

    }

    public struct UpdateExpression : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case UpdateExpression }
        public let `operator`: String
        public let argument: Expression
        public let prefix: Bool

    }

    public struct VariableDeclaration : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case VariableDeclaration }
        public let declarations: [VariableDeclarator]
        public let kind: String

    }

    public struct VariableDeclarator : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case VariableDeclarator }
        public let id: OneOf2<BindingIdentifier, BindingPattern>
        public let `init`: Nullable<Expression>

    }

    public struct WhileStatement : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case WhileStatement }
        public let test: Expression
        public let body: Statement

    }

    public struct WithStatement : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case WithStatement }
        public let object: Expression
        public let body: Statement

    }

    public struct YieldExpression : EsprimaAST {
        public let type: NodeType
        public enum NodeType : String, Codable { case YieldExpression }
        public let argument: Nullable<Expression>
        public let delegate: Bool
    }
}




