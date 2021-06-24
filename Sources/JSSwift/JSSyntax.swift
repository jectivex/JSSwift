import BricBrac

public protocol JSSyntaxNodeType : Pure {
    /// The name of the AST Type
    var typeName: String { get }
}

/// See: [Estree Node Objects](https://github.com/estree/estree/blob/master/es5.md#node-objects)
public protocol JSSyntaxNode : JSSyntaxNodeType {
    associatedtype NodeType : RawRepresentable where NodeType.RawValue == String

    /// The type field is a string representing the AST variant type. Each subtype of Node is documented below with the specific string of its type field. You can use this field to determine which interface a node implements.
    var type: NodeType { get }

    /// The loc field represents the source location information of the node. If the node contains no information about the source location, the field is null; otherwise it is an object consisting of a start position (the position of the first character of the parsed source region) and an end position (the position of the first character after the parsed source region)
    var loc: SourceLocation? { get }

    /// The optional range location for this token
    var range: [Int]? { get }
}

public extension JSSyntaxNode {
    var typeName: String { type.rawValue }
}


public extension JavaScriptParser {
    /// Parses a JavaScript script.
    ///
    /// More info: [Syntactic Analysis](https://esprima.readthedocs.io/en/4.0/syntactic-analysis.html)
    /// - TODO: @available(*, deprecated, renamed: "parse(script:options:)")
    func parseJSSyntax(script javaScript: String, options: ParseOptions = .init()) throws -> JSSyntax.Script {
        return try ctx.trying { // invoke the cached function with the encoded arguments
            parseScriptFunction.call(withArguments: [ctx.string(javaScript), try ctx.encode(options)])
        }.toDecodable(ofType: JSSyntax.Script.self)
    }


    /// Parses a JavaScript module.
    ///
    /// This differs from `parse(script:)` in that it permits module syntax like imports.
    ///
    /// More info: [Syntactic Analysis](https://esprima.readthedocs.io/en/4.0/syntactic-analysis.html)
    /// - TODO: @available(*, deprecated, renamed: "parse(script:module:)")
    func parseJSSyntax(module javaScript: String, options: ParseOptions = .init()) throws -> JSSyntax.Module {
        return try ctx.trying { // invoke the cached function with the encoded arguments
            parseModuleFunction.call(withArguments: [ctx.string(javaScript), try ctx.encode(options)])
        }.toDecodable(ofType: JSSyntax.Module.self)
    }
}

/// - TODO: @available(*, deprecated, renamed: "ESTree")
public enum JSSyntax {

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct Script : JSSyntaxNode {
        public init(type: ProgramNodeType = .Program, body: [StatementListItem], sourceType: String) {
            self.type = type
            self.body = body
            self.sourceType = sourceType
        }

        public let type: ProgramNodeType
        public enum ProgramNodeType : String, Codable { case Program }
        public var body: [StatementListItem]
        public var sourceType: String
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct Module : JSSyntaxNode {
        public init(type: ProgramNodeType = .Program, body: [ModuleItem], sourceType: String) {
            self.type = type
            self.body = body
            self.sourceType = sourceType
        }

        public let type: ProgramNodeType
        public enum ProgramNodeType : String, Codable { case Program }
        public var body: [ModuleItem]
        public var sourceType: String
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }


    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ArrayExpression : JSSyntaxNode {
        public init(type: ArrayExpressionNodeType = .ArrayExpression, elements: Array<Nullable<ArrayExpressionElement>>) {
            self.type = type
            self.elements = elements
        }

        public let type: ArrayExpressionNodeType
        public enum ArrayExpressionNodeType : String, Codable { case ArrayExpression }
        public var elements: Array<Nullable<ArrayExpressionElement>>
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html#array-pattern
    public struct ArrayPattern : JSSyntaxNode {
        public init(type: ArrayPatternNodeType = .ArrayPattern, elements: [Nullable<ArrayPatternElement>]) {
            self.type = type
            self.elements = elements
        }
        
        public let type: ArrayPatternNodeType
        public enum ArrayPatternNodeType : String, Codable { case ArrayPattern }
        public var elements: [Nullable<ArrayPatternElement>]
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ArrowFunctionExpression : JSSyntaxNode {
        public init(type: ArrowFunctionExpressionNodeType = .ArrowFunctionExpression, id: Optional<Identifier>, params: [FunctionParameter], body: OneOf<BlockStatement>.Or<Expression>, generator: Bool, expression: Bool, async: Bool) {
            self.type = type
            self.id = id
            self.params = params
            self.body = body
            self.generator = generator
            self.expression = expression
            self.async = async
        }

        public let type: ArrowFunctionExpressionNodeType
        public enum ArrowFunctionExpressionNodeType : String, Codable { case ArrowFunctionExpression }
        public var id: Optional<Identifier>
        public var params: [FunctionParameter]
        public var body: OneOf<BlockStatement>.Or<Expression>
        public var generator: Bool
        public var expression: Bool
        public var async: Bool
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct AssignmentExpression : JSSyntaxNode {
        public init(type: AssignmentExpressionNodeType = .AssignmentExpression, operator: String, left: Expression, right: Expression) {
            self.type = type
            self.`operator` = `operator`
            self.left = left
            self.right = right
        }

        public let type: AssignmentExpressionNodeType
        public enum AssignmentExpressionNodeType : String, Codable { case AssignmentExpression}
        public var `operator`: String
        public var left: Expression
        public var right: Expression
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct AssignmentPattern : JSSyntaxNode {
        public init(type: AssignmentPatternNodeType = .AssignmentPattern, left: OneOf<BindingIdentifier>.Or<BindingPattern>, right: Expression) {
            self.type = type
            self.left = left
            self.right = right
        }

        public let type: AssignmentPatternNodeType
        public enum AssignmentPatternNodeType : String, Codable { case AssignmentPattern }
        public var left: OneOf<BindingIdentifier>.Or<BindingPattern>
        public var right: Expression
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct AsyncArrowFunctionExpression : JSSyntaxNode {
        public init(type: AsyncArrowFunctionExpressionNodeType = .AsyncArrowFunctionExpression, id: Optional<Identifier>, params: [FunctionParameter], body: OneOf<BlockStatement>.Or<Expression>, generator: Bool, expression: Bool, async: Bool) {
            self.type = type
            self.id = id
            self.params = params
            self.body = body
            self.generator = generator
            self.expression = expression
            self.async = async
        }

        public let type: AsyncArrowFunctionExpressionNodeType
        public enum AsyncArrowFunctionExpressionNodeType : String, Codable { case AsyncArrowFunctionExpression }
        public var id: Optional<Identifier>
        public var params: [FunctionParameter]
        public var body: OneOf<BlockStatement>.Or<Expression>
        public var generator: Bool
        public var expression: Bool
        public var async: Bool
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct AsyncFunctionDeclaration : JSSyntaxNode {
        public init(type: AsyncFunctionDeclarationNodeType = .AsyncFunctionDeclaration, id: Optional<Identifier>, params: [FunctionParameter], body: BlockStatement, generator: Bool, expression: Bool, async: Bool) {
            self.type = type
            self.id = id
            self.params = params
            self.body = body
            self.generator = generator
            self.expression = expression
            self.async = async
        }

        public let type: AsyncFunctionDeclarationNodeType
        public enum AsyncFunctionDeclarationNodeType : String, Codable { case AsyncFunctionDeclaration }
        public var id: Optional<Identifier>
        public var params: [FunctionParameter]
        public var body: BlockStatement
        public var generator: Bool
        public var expression: Bool
        public var async: Bool
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct AsyncFunctionExpression : JSSyntaxNode {
        public init(type: AsyncFunctionExpressionNodeType = .AsyncFunctionExpression, id: Optional<Identifier>, params: [FunctionParameter], body: BlockStatement, generator: Bool, expression: Bool, async: Bool) {
            self.type = type
            self.id = id
            self.params = params
            self.body = body
            self.generator = generator
            self.expression = expression
            self.async = async
        }

        public let type: AsyncFunctionExpressionNodeType
        public enum AsyncFunctionExpressionNodeType : String, Codable { case AsyncFunctionExpression }
        public var id: Optional<Identifier>
        public var params: [FunctionParameter]
        public var body: BlockStatement
        public var generator: Bool
        public var expression: Bool
        public var async: Bool
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct AwaitExpression : JSSyntaxNode {
        public init(type: AwaitExpressionNodeType = .AwaitExpression, argument: Expression) {
            self.type = type
            self.argument = argument
        }

        public let type: AwaitExpressionNodeType
        public enum AwaitExpressionNodeType : String, Codable { case AwaitExpression }
        public var argument: Expression
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct BinaryExpression : JSSyntaxNode {
        public init(type: BinaryExpressionNodeType = .BinaryExpression, `operator`: String, left: Expression, right: Expression) {
            self.type = type
            self.`operator` = `operator`
            self.left = left
            self.right = right
        }

        public let type: BinaryExpressionNodeType
        public enum BinaryExpressionNodeType : String, Codable { case BinaryExpression }
        public var `operator`: String
        public var left: Expression
        public var right: Expression
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct LogicalExpression : JSSyntaxNode {
        public init(type: LogicalExpressionNodeType = .LogicalExpression, `operator`: String, left: Expression, right: Expression) {
            self.type = type
            self.`operator` = `operator`
            self.left = left
            self.right = right
        }

        public let type: LogicalExpressionNodeType
        public enum LogicalExpressionNodeType : String, Codable { case LogicalExpression }
        public var `operator`: String
        public var left: Expression
        public var right: Expression
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct BlockStatement : JSSyntaxNode {
        public init(type: BlockStatementNodeType = .BlockStatement, body: [StatementListItem]) {
            self.type = type
            self.body = body
        }

        public let type: BlockStatementNodeType
        public enum BlockStatementNodeType : String, Codable { case BlockStatement }
        public var body: [StatementListItem]
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct BreakStatement : JSSyntaxNode {
        public init(type: BreakStatementNodeType = .BreakStatement, label: Optional<Identifier>) {
            self.type = type
            self.label = label
        }

        public let type: BreakStatementNodeType
        public enum BreakStatementNodeType : String, Codable { case BreakStatement }
        public var label: Optional<Identifier>
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct CallExpression : JSSyntaxNode {
        public init(type: CallExpressionNodeType = .CallExpression, callee: OneOf<Expression>.Or<Import>, arguments: [ArgumentListElement]) {
            self.type = type
            self.callee = callee
            self.arguments = arguments
        }

        public let type: CallExpressionNodeType
        public enum CallExpressionNodeType : String, Codable { case CallExpression }
        public var callee: OneOf<Expression>.Or<Import>
        public var arguments: [ArgumentListElement]
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct CatchClause : JSSyntaxNode {
        public init(type: CatchClauseNodeType = .CatchClause, param: OneOf<BindingIdentifier>.Or<BindingPattern>, body: BlockStatement) {
            self.type = type
            self.param = param
            self.body = body
        }

        public let type: CatchClauseNodeType
        public enum CatchClauseNodeType : String, Codable { case CatchClause }
        public var param: OneOf<BindingIdentifier>.Or<BindingPattern>
        public var body: BlockStatement
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ChainExpression : JSSyntaxNode {
        public init(type: ChainExpressionNodeType = .ChainExpression, expression: ChainElement) {
            self.type = type
            self.expression = expression
        }

        public let type: ChainExpressionNodeType
        public enum ChainExpressionNodeType : String, Codable { case ChainExpression }
        public var expression: ChainElement
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ClassBody : JSSyntaxNode {
        public init(type: ClassBodyNodeType = .ClassBody, body: [MethodDefinition]) {
            self.type = type
            self.body = body
        }

        public let type: ClassBodyNodeType
        public enum ClassBodyNodeType : String, Codable { case ClassBody }
        public var body: [MethodDefinition]
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ClassDeclaration : JSSyntaxNode {
        public init(type: ClassDeclarationNodeType = .ClassDeclaration, id: Optional<Identifier>, superClass: Optional<Identifier>, body: ClassBody) {
            self.type = type
            self.id = id
            self.superClass = superClass
            self.body = body
        }

        public let type: ClassDeclarationNodeType
        public enum ClassDeclarationNodeType : String, Codable { case ClassDeclaration }
        public var id: Optional<Identifier>
        public var superClass: Optional<Identifier>
        public var body: ClassBody
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ClassExpression : JSSyntaxNode {
        public init(type: ClassExpressionNodeType = .ClassExpression, id: Optional<Identifier>, superClass: Optional<Identifier>, body: ClassBody) {
            self.type = type
            self.id = id
            self.superClass = superClass
            self.body = body
        }

        public let type: ClassExpressionNodeType
        public enum ClassExpressionNodeType : String, Codable { case ClassExpression }
        public var id: Optional<Identifier>
        public var superClass: Optional<Identifier>
        public var body: ClassBody
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ComputedMemberExpression : JSSyntaxNode {
        public init(type: ComputedMemberExpressionNodeType = .ComputedMemberExpression, computed: Bool, object: Expression, property: Expression) {
            self.type = type
            self.computed = computed
            self.object = object
            self.property = property
        }

        public let type: ComputedMemberExpressionNodeType
        public enum ComputedMemberExpressionNodeType : String, Codable { case ComputedMemberExpression }
        public var computed: Bool
        public var object: Expression
        public var property: Expression
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ConditionalExpression : JSSyntaxNode {
        public init(type: ConditionalExpressionNodeType = .ConditionalExpression, test: Expression, consequent: Expression, alternate: Expression) {
            self.type = type
            self.test = test
            self.consequent = consequent
            self.alternate = alternate
        }

        public let type: ConditionalExpressionNodeType
        public enum ConditionalExpressionNodeType : String, Codable { case ConditionalExpression }
        public var test: Expression
        public var consequent: Expression
        public var alternate: Expression
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ContinueStatement : JSSyntaxNode {
        public init(type: ContinueStatementNodeType = .ContinueStatement, label: Optional<Identifier>) {
            self.type = type
            self.label = label
        }

        public let type: ContinueStatementNodeType
        public enum ContinueStatementNodeType : String, Codable { case ContinueStatement }
        public var label: Optional<Identifier>
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct DebuggerStatement : JSSyntaxNode {
        public init(type: DebuggerStatementNodeType = .DebuggerStatement) {
            self.type = type
        }

        public let type: DebuggerStatementNodeType
        public enum DebuggerStatementNodeType : String, Codable { case DebuggerStatement }
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct Directive : JSSyntaxNode {
        public init(type: DirectiveNodeType = .Directive, expression: Expression, directive: String) {
            self.type = type
            self.expression = expression
            self.directive = directive
        }

        public let type: DirectiveNodeType
        public enum DirectiveNodeType : String, Codable { case Directive }
        public var expression: Expression
        public var directive: String
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct DoWhileStatement : JSSyntaxNode {
        public init(type: DoWhileStatementNodeType = .DoWhileStatement, body: Statement, test: Expression) {
            self.type = type
            self.body = body
            self.test = test
        }

        public let type: DoWhileStatementNodeType
        public enum DoWhileStatementNodeType : String, Codable { case DoWhileStatement }
        public var body: Statement
        public var test: Expression
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct EmptyStatement : JSSyntaxNode {
        public init(type: EmptyStatementNodeType = .EmptyStatement) {
            self.type = type
        }

        public let type: EmptyStatementNodeType
        public enum EmptyStatementNodeType : String, Codable { case EmptyStatement }
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ExportAllDeclaration : JSSyntaxNode {
        public init(type: ExportAllDeclarationNodeType = .ExportAllDeclaration, source: Literal) {
            self.type = type
            self.source = source
        }

        public let type: ExportAllDeclarationNodeType
        public enum ExportAllDeclarationNodeType : String, Codable { case ExportAllDeclaration }
        public var source: Literal
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ExportDefaultDeclaration : JSSyntaxNode {
        public init(type: ExportDefaultDeclarationNodeType = .ExportDefaultDeclaration, declaration: ExportableDefaultDeclaration) {
            self.type = type
            self.declaration = declaration
        }

        public let type: ExportDefaultDeclarationNodeType
        public enum ExportDefaultDeclarationNodeType : String, Codable { case ExportDefaultDeclaration }
        public var declaration: ExportableDefaultDeclaration
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ExportNamedDeclaration : JSSyntaxNode {
        public init(type: ExportNamedDeclarationNodeType = .ExportNamedDeclaration, declaration: Optional<ExportableNamedDeclaration>, specifiers: [ExportSpecifier], source: Optional<Literal>) {
            self.type = type
            self.declaration = declaration
            self.specifiers = specifiers
            self.source = source
        }

        public let type: ExportNamedDeclarationNodeType
        public enum ExportNamedDeclarationNodeType : String, Codable { case ExportNamedDeclaration }
        public var declaration: Optional<ExportableNamedDeclaration>
        public var specifiers: [ExportSpecifier]
        public var source: Optional<Literal>
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ExportSpecifier : JSSyntaxNode {
        public init(type: ExportSpecifierNodeType = .ExportSpecifier, exported: Identifier, local: Identifier) {
            self.type = type
            self.exported = exported
            self.local = local
        }

        public let type: ExportSpecifierNodeType
        public enum ExportSpecifierNodeType : String, Codable { case ExportSpecifier }
        public var exported: Identifier
        public var local: Identifier
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ExpressionStatement : JSSyntaxNode {
        public init(type: ExpressionStatementNodeType = .ExpressionStatement, expression: Expression, directive: String?) {
            self.type = type
            self.expression = expression
            self.directive = directive
        }

        public let type: ExpressionStatementNodeType
        public enum ExpressionStatementNodeType : String, Codable { case ExpressionStatement }
        public var expression: Expression
        public var directive: String?
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ForInStatement : JSSyntaxNode {
        public init(type: ForInStatementNodeType = .ForInStatement, left: OneOf<VariableDeclaration>.Or<Expression>, right: Expression, body: Statement, each: Bool) {
            self.type = type
            self.left = left
            self.right = right
            self.body = body
            self.each = each
        }

        public let type: ForInStatementNodeType
        public enum ForInStatementNodeType : String, Codable { case ForInStatement }
        public var left: OneOf<VariableDeclaration>.Or<Expression>
        public var right: Expression
        public var body: Statement
        public var each: Bool
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ForOfStatement : JSSyntaxNode {
        public init(type: ForOfStatementNodeType = .ForOfStatement, left: OneOf<VariableDeclaration>.Or<Expression>, right: Expression, body: Statement) {
            self.type = type
            self.left = left
            self.right = right
            self.body = body
        }

        public let type: ForOfStatementNodeType
        public enum ForOfStatementNodeType : String, Codable { case ForOfStatement }
        public var left: OneOf<VariableDeclaration>.Or<Expression>
        public var right: Expression
        public var body: Statement
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ForStatement : JSSyntaxNode {
        public init(type: ForStatementNodeType = .ForStatement, `init`: Nullable<OneOf<VariableDeclaration>.Or<Expression>>, test: Nullable<Expression>, update: Nullable<Expression>, body: Statement) {
            self.type = type
            self.`init` = `init`
            self.test = test
            self.update = update
            self.body = body
        }

        public let type: ForStatementNodeType
        public enum ForStatementNodeType : String, Codable { case ForStatement }
        public var `init`: Nullable<OneOf<VariableDeclaration>.Or<Expression>>
        public var test: Nullable<Expression>
        public var update: Nullable<Expression>
        public var body: Statement
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct FunctionDeclaration : JSSyntaxNode {
        public init(type: FunctionDeclarationNodeType = .FunctionDeclaration, id: Optional<Identifier>, params: [FunctionParameter], body: BlockStatement, generator: Bool, expression: Bool, async: Bool) {
            self.type = type
            self.id = id
            self.params = params
            self.body = body
            self.generator = generator
            self.expression = expression
            self.async = async
        }

        public let type: FunctionDeclarationNodeType
        public enum FunctionDeclarationNodeType : String, Codable { case FunctionDeclaration }
        public var id: Optional<Identifier>
        public var params: [FunctionParameter]
        public var body: BlockStatement
        public var generator: Bool
        public var expression: Bool
        public var async: Bool
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct FunctionExpression : JSSyntaxNode {
        public init(type: FunctionExpressionNodeType = .FunctionExpression, id: Optional<Identifier>, params: [FunctionParameter], body: BlockStatement, generator: Bool, expression: Bool, async: Bool) {
            self.type = type
            self.id = id
            self.params = params
            self.body = body
            self.generator = generator
            self.expression = expression
            self.async = async
        }

        public let type: FunctionExpressionNodeType
        public enum FunctionExpressionNodeType : String, Codable { case FunctionExpression }
        public var id: Optional<Identifier>
        public var params: [FunctionParameter]
        public var body: BlockStatement
        public var generator: Bool
        public var expression: Bool
        public var async: Bool
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct Identifier : JSSyntaxNode {
        public init(type: IdentifierNodeType = .Identifier, name: String) {
            self.type = type
            self.name = name
        }

        public let type: IdentifierNodeType
        public enum IdentifierNodeType : String, Codable { case Identifier }
        public var name: String
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct IfStatement : JSSyntaxNode {
        public init(type: IfStatementNodeType = .IfStatement, test: Expression, consequent: Statement, alternate: Optional<Statement>) {
            self.type = type
            self.test = test
            self.consequent = consequent
            self.alternate = alternate
        }

        public let type: IfStatementNodeType
        public enum IfStatementNodeType : String, Codable { case IfStatement }
        public var test: Expression
        public var consequent: Statement
        public var alternate: Optional<Statement>
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct Import : JSSyntaxNode {
        public init(type: ImportNodeType = .Import) {
            self.type = type
        }

        public let type: ImportNodeType
        public enum ImportNodeType : String, Codable { case Import }
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ImportDeclaration : JSSyntaxNode {
        public init(type: ImportDeclarationNodeType = .ImportDeclaration, specifiers: [ImportDeclarationSpecifier], source: Literal) {
            self.type = type
            self.specifiers = specifiers
            self.source = source
        }

        public let type: ImportDeclarationNodeType
        public enum ImportDeclarationNodeType : String, Codable { case ImportDeclaration }
        public var specifiers: [ImportDeclarationSpecifier]
        public var source: Literal
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ImportDefaultSpecifier : JSSyntaxNode {
        public init(type: ImportDefaultSpecifierNodeType = .ImportDefaultSpecifier, local: Identifier) {
            self.type = type
            self.local = local
        }

        public let type: ImportDefaultSpecifierNodeType
        public enum ImportDefaultSpecifierNodeType : String, Codable { case ImportDefaultSpecifier }
        public var local: Identifier
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ImportNamespaceSpecifier : JSSyntaxNode {
        public init(type: ImportNamespaceSpecifierNodeType = .ImportNamespaceSpecifier, local: Identifier) {
            self.type = type
            self.local = local
        }

        public let type: ImportNamespaceSpecifierNodeType
        public enum ImportNamespaceSpecifierNodeType : String, Codable { case ImportNamespaceSpecifier }
        public var local: Identifier
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ImportSpecifier : JSSyntaxNode {
        public init(type: ImportSpecifierNodeType = .ImportSpecifier, local: Identifier, imported: Identifier) {
            self.type = type
            self.local = local
            self.imported = imported
        }

        public let type: ImportSpecifierNodeType
        public enum ImportSpecifierNodeType : String, Codable { case ImportSpecifier }
        public var local: Identifier
        public var imported: Identifier
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct LabeledStatement : JSSyntaxNode {
        public init(type: LabeledStatementNodeType = .LabeledStatement, label: Identifier, body: Statement) {
            self.type = type
            self.label = label
            self.body = body
        }

        public let type: LabeledStatementNodeType
        public enum LabeledStatementNodeType : String, Codable { case LabeledStatement }
        public var label: Identifier
        public var body: Statement
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct Literal : JSSyntaxNode {
        public init(type: LiteralNodeType = .Literal, value: Optional<OneOf<Bool>.Or<Double>.Or<String>.Or<RegExp>>, raw: String, regex: Optional<Regex>) {
            self.type = type
            self.value = value
            self.raw = raw
            self.regex = regex
        }

        public let type: LiteralNodeType
        public enum LiteralNodeType : String, Codable { case Literal }
        public var value: Optional<OneOf<Bool>.Or<Double>.Or<String>.Or<RegExp>>
        public var raw: String
        public var regex: Optional<Regex>
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil

        /// Hollow object signifying a regexp
        public struct RegExp : Codable, Hashable {
            public init() { }
        }
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct MemberExpression : JSSyntaxNode {
        public init(type: MemberExpressionNodeType = .MemberExpression, computed: Bool, object: Expression, property: Expression) {
            self.type = type
            self.computed = computed
            self.object = object
            self.property = property
        }

        public let type: MemberExpressionNodeType
        public enum MemberExpressionNodeType : String, Codable { case MemberExpression }
        public var computed: Bool
        public var object: Expression
        public var property: Expression
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }


    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct MetaProperty : JSSyntaxNode {
        public init(type: MetaPropertyNodeType = .MetaProperty, meta: Identifier, property: Identifier) {
            self.type = type
            self.meta = meta
            self.property = property
        }

        public let type: MetaPropertyNodeType
        public enum MetaPropertyNodeType : String, Codable { case MetaProperty }
        public var meta: Identifier
        public var property: Identifier
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct MethodDefinition : JSSyntaxNode {
        public init(type: MethodDefinitionNodeType = .MethodDefinition, key: Optional<Expression>, computed: Bool, value: Optional<OneOf<AsyncFunctionExpression>.Or<FunctionExpression>>, kind: MethodDefinitionKind, `static`: Bool) {
            self.type = type
            self.key = key
            self.computed = computed
            self.value = value
            self.kind = kind
            self.`static` = `static`
        }

        public let type: MethodDefinitionNodeType
        public enum MethodDefinitionNodeType : String, Codable { case MethodDefinition }
        public var key: Optional<Expression>
        public var computed: Bool
        public var value: Optional<OneOf<AsyncFunctionExpression>.Or<FunctionExpression>>
        public var kind: MethodDefinitionKind
        public enum MethodDefinitionKind : String, Codable { case method, constructor }
        public var `static`: Bool
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct NewExpression : JSSyntaxNode {
        public init(type: NewExpressionNodeType = .NewExpression, callee: Expression, arguments: [ArgumentListElement]) {
            self.type = type
            self.callee = callee
            self.arguments = arguments
        }

        public let type: NewExpressionNodeType
        public enum NewExpressionNodeType : String, Codable { case NewExpression }
        public var callee: Expression
        public var arguments: [ArgumentListElement]
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ObjectExpression : JSSyntaxNode {
        public init(type: ObjectExpressionNodeType = .ObjectExpression, properties: [ObjectExpressionProperty]) {
            self.type = type
            self.properties = properties
        }

        public let type: ObjectExpressionNodeType
        public enum ObjectExpressionNodeType : String, Codable { case ObjectExpression }
        public var properties: [ObjectExpressionProperty]
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ObjectPattern : JSSyntaxNode {
        public init(type: ObjectPatternNodeType = .ObjectPattern, properties: [ObjectPatternProperty]) {
            self.type = type
            self.properties = properties
        }

        public let type: ObjectPatternNodeType
        public enum ObjectPatternNodeType : String, Codable { case ObjectPattern }
        public var properties: [ObjectPatternProperty]
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct Property : JSSyntaxNode {
        public init(type: PropertyNodeType = .Property, key: PropertyKey, computed: Bool, value: Optional<Expression>, kind: String, method: Bool, shorthand: Bool) {
            self.type = type
            self.key = key
            self.computed = computed
            self.value = value
            self.kind = kind
            self.method = method
            self.shorthand = shorthand
        }

        public let type: PropertyNodeType
        public enum PropertyNodeType : String, Codable { case Property }
        public var key: PropertyKey
        public var computed: Bool
        public var value: Optional<Expression>
        public var kind: String
        public var method: Bool
        public var shorthand: Bool
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct RegexLiteral : JSSyntaxNode {
        public init(type: RegexLiteralNodeType = .RegexLiteral, value: Bric, raw: String, regex: Regex) {
            self.type = type
            self.value = value
            self.raw = raw
            self.regex = regex
        }

        public let type: RegexLiteralNodeType
        public enum RegexLiteralNodeType : String, Codable { case RegexLiteral }
        public var value: Bric; // RegExp
        public var raw: String
        public var regex: Regex
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct RestElement : JSSyntaxNode {
        public init(type: RestElementNodeType = .RestElement, argument: OneOf<BindingIdentifier>.Or<BindingPattern>) {
            self.type = type
            self.argument = argument
        }

        public let type: RestElementNodeType
        public enum RestElementNodeType : String, Codable { case RestElement }
        public var argument: OneOf<BindingIdentifier>.Or<BindingPattern>
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ReturnStatement : JSSyntaxNode {
        public init(type: ReturnStatementNodeType = .ReturnStatement, argument: Optional<Expression>) {
            self.type = type
            self.argument = argument
        }

        public let type: ReturnStatementNodeType
        public enum ReturnStatementNodeType : String, Codable { case ReturnStatement }
        public var argument: Optional<Expression>
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct SequenceExpression : JSSyntaxNode {
        public init(type: SequenceExpressionNodeType = .SequenceExpression, expressions: [Expression]) {
            self.type = type
            self.expressions = expressions
        }

        public let type: SequenceExpressionNodeType
        public enum SequenceExpressionNodeType : String, Codable { case SequenceExpression }
        public var expressions: [Expression]
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct SpreadElement : JSSyntaxNode {
        public init(type: SpreadElementNodeType = .SpreadElement, argument: Expression) {
            self.type = type
            self.argument = argument
        }

        public let type: SpreadElementNodeType
        public enum SpreadElementNodeType : String, Codable { case SpreadElement }
        public var argument: Expression
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct StaticMemberExpression : JSSyntaxNode {
        public init(type: StaticMemberExpressionNodeType = .StaticMemberExpression, computed: Bool, object: Expression, property: Expression) {
            self.type = type
            self.computed = computed
            self.object = object
            self.property = property
        }

        public let type: StaticMemberExpressionNodeType
        public enum StaticMemberExpressionNodeType : String, Codable { case StaticMemberExpression }
        public var computed: Bool
        public var object: Expression
        public var property: Expression
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct Super : JSSyntaxNode {
        public init(type: SuperNodeType = .Super) {
            self.type = type
        }

        public let type: SuperNodeType
        public enum SuperNodeType : String, Codable { case Super }
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct SwitchCase : JSSyntaxNode {
        public init(type: SwitchCaseNodeType = .SwitchCase, test: Optional<Expression>, consequent: [Statement]) {
            self.type = type
            self.test = test
            self.consequent = consequent
        }

        public let type: SwitchCaseNodeType
        public enum SwitchCaseNodeType : String, Codable { case SwitchCase }
        public var test: Optional<Expression>
        public var consequent: [Statement]
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct SwitchStatement : JSSyntaxNode {
        public init(type: SwitchStatementNodeType = .SwitchStatement, discriminant: Expression, cases: [SwitchCase]) {
            self.type = type
            self.discriminant = discriminant
            self.cases = cases
        }

        public let type: SwitchStatementNodeType
        public enum SwitchStatementNodeType : String, Codable { case SwitchStatement }
        public var discriminant: Expression
        public var cases: [SwitchCase]
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct TaggedTemplateExpression : JSSyntaxNode {
        public init(type: TaggedTemplateExpressionNodeType = .TaggedTemplateExpression, tag: Expression, quasi: TemplateLiteral) {
            self.type = type
            self.tag = tag
            self.quasi = quasi
        }

        public let type: TaggedTemplateExpressionNodeType
        public enum TaggedTemplateExpressionNodeType : String, Codable { case TaggedTemplateExpression }
        public var tag: Expression
        public var quasi: TemplateLiteral
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct TemplateElementValue : Hashable, Codable {
        public var cooked: String
        public var raw: String
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct TemplateElement : JSSyntaxNode {
        public init(type: TemplateElementValueNodeType = .TemplateElement, value: TemplateElementValue, tail: Bool) {
            self.type = type
            self.value = value
            self.tail = tail
        }

        public let type: TemplateElementValueNodeType
        public enum TemplateElementValueNodeType : String, Codable { case TemplateElement }
        public var value: TemplateElementValue
        public var tail: Bool
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct TemplateLiteral : JSSyntaxNode {
        public init(type: TemplateLiteralNodeType = .TemplateLiteral, quasis: [TemplateElement], expressions: [Expression]) {
            self.type = type
            self.quasis = quasis
            self.expressions = expressions
        }

        public let type: TemplateLiteralNodeType
        public enum TemplateLiteralNodeType : String, Codable { case TemplateLiteral }
        public var quasis: [TemplateElement]
        public var expressions: [Expression]
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ThisExpression : JSSyntaxNode {
        public init(type: ThisExpressionNodeType = .ThisExpression) {
            self.type = type
        }

        public let type: ThisExpressionNodeType
        public enum ThisExpressionNodeType : String, Codable { case ThisExpression }
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ThrowStatement : JSSyntaxNode {
        public init(type: ThrowStatementNodeType = .ThrowStatement, argument: Expression) {
            self.type = type
            self.argument = argument
        }

        public let type: ThrowStatementNodeType
        public enum ThrowStatementNodeType : String, Codable { case ThrowStatement }
        public var argument: Expression
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct TryStatement : JSSyntaxNode {
        public init(type: TryStatementNodeType = .TryStatement, block: BlockStatement, handler: Optional<CatchClause>, finalizer: Optional<BlockStatement>) {
            self.type = type
            self.block = block
            self.handler = handler
            self.finalizer = finalizer
        }

        public let type: TryStatementNodeType
        public enum TryStatementNodeType : String, Codable { case TryStatement }
        public var block: BlockStatement
        public var handler: Optional<CatchClause>
        public var finalizer: Optional<BlockStatement>
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct UnaryExpression : JSSyntaxNode {
        public init(type: UnaryExpressionNodeType = .UnaryExpression, `operator`: String, argument: Expression, prefix: Bool) {
            self.type = type
            self.`operator` = `operator`
            self.argument = argument
            self.prefix = prefix
        }

        public let type: UnaryExpressionNodeType
        public enum UnaryExpressionNodeType : String, Codable { case UnaryExpression }
        public var `operator`: String
        public var argument: Expression
        public var prefix: Bool
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct UpdateExpression : JSSyntaxNode {
        public init(type: UpdateExpressionNodeType = .UpdateExpression, `operator`: String, argument: Expression, prefix: Bool) {
            self.type = type
            self.`operator` = `operator`
            self.argument = argument
            self.prefix = prefix
        }

        public let type: UpdateExpressionNodeType
        public enum UpdateExpressionNodeType : String, Codable { case UpdateExpression }
        public var `operator`: String
        public var argument: Expression
        public var prefix: Bool
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct VariableDeclaration : JSSyntaxNode {
        public init(type: VariableDeclarationNodeType = .VariableDeclaration, declarations: [VariableDeclarator], kind: String) {
            self.type = type
            self.declarations = declarations
            self.kind = kind
        }

        public let type: VariableDeclarationNodeType
        public enum VariableDeclarationNodeType : String, Codable { case VariableDeclaration }
        public var declarations: [VariableDeclarator]
        public var kind: String
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct VariableDeclarator : JSSyntaxNode {
        public init(type: VariableDeclaratorNodeType = .VariableDeclarator, id: OneOf<BindingIdentifier>.Or<BindingPattern>, `init`: Optional<Expression>) {
            self.type = type
            self.id = id
            self.`init` = `init`
        }

        public let type: VariableDeclaratorNodeType
        public enum VariableDeclaratorNodeType : String, Codable { case VariableDeclarator }
        public var id: OneOf<BindingIdentifier>.Or<BindingPattern>
        public var `init`: Optional<Expression>
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct WhileStatement : JSSyntaxNode {
        public init(type: WhileStatementNodeType = .WhileStatement, test: Expression, body: Statement) {
            self.type = type
            self.test = test
            self.body = body
        }

        public let type: WhileStatementNodeType
        public enum WhileStatementNodeType : String, Codable { case WhileStatement }
        public var test: Expression
        public var body: Statement
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct WithStatement : JSSyntaxNode {
        public init(type: WithStatementNodeType = .WithStatement, object: Expression, body: Statement) {
            self.type = type
            self.object = object
            self.body = body
        }

        public let type: WithStatementNodeType
        public enum WithStatementNodeType : String, Codable { case WithStatement }
        public var object: Expression
        public var body: Statement
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct YieldExpression : JSSyntaxNode {
        public init(type: YieldExpressionNodeType = .YieldExpression, argument: Optional<Expression>, delegate: Bool) {
            self.type = type
            self.argument = argument
            self.delegate = delegate
        }

        public let type: YieldExpressionNodeType
        public enum YieldExpressionNodeType : String, Codable { case YieldExpression }
        public var argument: Optional<Expression>
        public var delegate: Bool
        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }
}


/// - TODO: @available(*, deprecated, renamed: "ESTree")
extension JSSyntax {
    public indirect enum Expression : Hashable, Codable {
        case ThisExpression(ThisExpression)
        case Identifier(Identifier)
        case Literal(Literal)
        case SequenceExpression(SequenceExpression)
        case ArrayExpression(ArrayExpression)
        case MemberExpression(MemberExpression)
        case MetaProperty(MetaProperty)
        case CallExpression(CallExpression)
        case ObjectExpression(ObjectExpression)
        case FunctionExpression(FunctionExpression)
        case ArrowFunctionExpression(ArrowFunctionExpression)
        case ClassExpression(ClassExpression)
        case TaggedTemplateExpression(TaggedTemplateExpression)
        case Super(Super)
        case NewExpression(NewExpression)
        case UpdateExpression(UpdateExpression)
        case AwaitExpression(AwaitExpression)
        case UnaryExpression(UnaryExpression)
        case BinaryExpression(BinaryExpression)
        case LogicalExpression(LogicalExpression)
        case ConditionalExpression(ConditionalExpression)
        case YieldExpression(YieldExpression)
        case AssignmentExpression(AssignmentExpression)
        case AsyncArrowFunctionExpression(AsyncArrowFunctionExpression)
        case AsyncFunctionExpression(AsyncFunctionExpression)
        case ChainExpression(ChainExpression)
        case RegexLiteral(RegexLiteral)

        public init(from decoder: Decoder) throws {
            let typeName = try decoder
                .container(keyedBy: CodingKeys.self)
                .decode(String.self, forKey: .type)

            switch typeName {
            case JSSyntax.ThisExpression.NodeType.ThisExpression.rawValue:
                self = .ThisExpression(try .init(from: decoder))
            case JSSyntax.Identifier.NodeType.Identifier.rawValue:
                self = .Identifier(try .init(from: decoder))
            case JSSyntax.Literal.NodeType.Literal.rawValue:
                self = .Literal(try .init(from: decoder))
            case JSSyntax.SequenceExpression.NodeType.SequenceExpression.rawValue:
                self = .SequenceExpression(try .init(from: decoder))
            case JSSyntax.ArrayExpression.NodeType.ArrayExpression.rawValue:
                self = .ArrayExpression(try .init(from: decoder))
            case JSSyntax.MemberExpression.NodeType.MemberExpression.rawValue:
                self = .MemberExpression(try .init(from: decoder))
            case JSSyntax.MetaProperty.NodeType.MetaProperty.rawValue:
                self = .MetaProperty(try .init(from: decoder))
            case JSSyntax.CallExpression.NodeType.CallExpression.rawValue:
                self = .CallExpression(try .init(from: decoder))
            case JSSyntax.ObjectExpression.NodeType.ObjectExpression.rawValue:
                self = .ObjectExpression(try .init(from: decoder))
            case JSSyntax.FunctionExpression.NodeType.FunctionExpression.rawValue:
                self = .FunctionExpression(try .init(from: decoder))
            case JSSyntax.ArrowFunctionExpression.NodeType.ArrowFunctionExpression.rawValue:
                self = .ArrowFunctionExpression(try .init(from: decoder))
            case JSSyntax.ClassExpression.NodeType.ClassExpression.rawValue:
                self = .ClassExpression(try .init(from: decoder))
            case JSSyntax.TaggedTemplateExpression.NodeType.TaggedTemplateExpression.rawValue:
                self = .TaggedTemplateExpression(try .init(from: decoder))
            case JSSyntax.Super.NodeType.Super.rawValue:
                self = .Super(try .init(from: decoder))
            case JSSyntax.NewExpression.NodeType.NewExpression.rawValue:
                self = .NewExpression(try .init(from: decoder))
            case JSSyntax.UpdateExpression.NodeType.UpdateExpression.rawValue:
                self = .UpdateExpression(try .init(from: decoder))
            case JSSyntax.AwaitExpression.NodeType.AwaitExpression.rawValue:
                self = .AwaitExpression(try .init(from: decoder))
            case JSSyntax.UnaryExpression.NodeType.UnaryExpression.rawValue:
                self = .UnaryExpression(try .init(from: decoder))
            case JSSyntax.BinaryExpression.NodeType.BinaryExpression.rawValue:
                self = .BinaryExpression(try .init(from: decoder))
            case JSSyntax.LogicalExpression.NodeType.LogicalExpression.rawValue:
                self = .LogicalExpression(try .init(from: decoder))
            case JSSyntax.ConditionalExpression.NodeType.ConditionalExpression.rawValue:
                self = .ConditionalExpression(try .init(from: decoder))
            case JSSyntax.YieldExpression.NodeType.YieldExpression.rawValue:
                self = .YieldExpression(try .init(from: decoder))
            case JSSyntax.AssignmentExpression.NodeType.AssignmentExpression.rawValue:
                self = .AssignmentExpression(try .init(from: decoder))
            case JSSyntax.AsyncArrowFunctionExpression.NodeType.AsyncArrowFunctionExpression.rawValue:
                self = .AsyncArrowFunctionExpression(try .init(from: decoder))
            case JSSyntax.AsyncFunctionExpression.NodeType.AsyncFunctionExpression.rawValue:
                self = .AsyncFunctionExpression(try .init(from: decoder))
            case JSSyntax.ChainExpression.NodeType.ChainExpression.rawValue:
                self = .ChainExpression(try .init(from: decoder))
            case JSSyntax.RegexLiteral.NodeType.RegexLiteral.rawValue:
                self = .RegexLiteral(try .init(from: decoder))
            default:
                throw DecodingError.keyNotFound(CodingKeys.type, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Bad value for type: \(typeName)"))
            }
        }

        public func encode(to encoder: Encoder) throws {
            switch self {
            case .ThisExpression(let x): return try x.encode(to: encoder)
            case .Identifier(let x): return try x.encode(to: encoder)
            case .Literal(let x): return try x.encode(to: encoder)
            case .SequenceExpression(let x): return try x.encode(to: encoder)
            case .ArrayExpression(let x): return try x.encode(to: encoder)
            case .MemberExpression(let x): return try x.encode(to: encoder)
            case .MetaProperty(let x): return try x.encode(to: encoder)
            case .CallExpression(let x): return try x.encode(to: encoder)
            case .ObjectExpression(let x): return try x.encode(to: encoder)
            case .FunctionExpression(let x): return try x.encode(to: encoder)
            case .ArrowFunctionExpression(let x): return try x.encode(to: encoder)
            case .ClassExpression(let x): return try x.encode(to: encoder)
            case .TaggedTemplateExpression(let x): return try x.encode(to: encoder)
            case .Super(let x): return try x.encode(to: encoder)
            case .NewExpression(let x): return try x.encode(to: encoder)
            case .UpdateExpression(let x): return try x.encode(to: encoder)
            case .AwaitExpression(let x): return try x.encode(to: encoder)
            case .UnaryExpression(let x): return try x.encode(to: encoder)
            case .BinaryExpression(let x): return try x.encode(to: encoder)
            case .LogicalExpression(let x): return try x.encode(to: encoder)
            case .ConditionalExpression(let x): return try x.encode(to: encoder)
            case .YieldExpression(let x): return try x.encode(to: encoder)
            case .AssignmentExpression(let x): return try x.encode(to: encoder)
            case .AsyncArrowFunctionExpression(let x): return try x.encode(to: encoder)
            case .AsyncFunctionExpression(let x): return try x.encode(to: encoder)
            case .ChainExpression(let x): return try x.encode(to: encoder)
            case .RegexLiteral(let x): return try x.encode(to: encoder)
            }
        }

        enum CodingKeys : String, CodingKey {
            case type
        }
    }

    public indirect enum Statement : Hashable, Codable {
        case BlockStatement(BlockStatement)
        case AsyncFunctionDeclaration(AsyncFunctionDeclaration)
        case BreakStatement(BreakStatement)
        case ContinueStatement(ContinueStatement)
        case DebuggerStatement(DebuggerStatement)
        case DoWhileStatement(DoWhileStatement)
        case EmptyStatement(EmptyStatement)
        case ExpressionStatement(ExpressionStatement)
        case Directive(Directive)
        case ForStatement(ForStatement)
        case ForInStatement(ForInStatement)
        case ForOfStatement(ForOfStatement)
        case FunctionDeclaration(FunctionDeclaration)
        case IfStatement(IfStatement)
        case LabeledStatement(LabeledStatement)
        case ReturnStatement(ReturnStatement)
        case SwitchStatement(SwitchStatement)
        case ThrowStatement(ThrowStatement)
        case TryStatement(TryStatement)
        case VariableDeclaration(VariableDeclaration)
        case WhileStatement(WhileStatement)
        case WithStatement(WithStatement)

        public init(from decoder: Decoder) throws {
            let typeName = try decoder
                .container(keyedBy: CodingKeys.self)
                .decode(String.self, forKey: .type)

            switch typeName {
            case JSSyntax.BlockStatement.NodeType.BlockStatement.rawValue:
                self = .BlockStatement(try .init(from: decoder))
            case JSSyntax.AsyncFunctionDeclaration.NodeType.AsyncFunctionDeclaration.rawValue:
                self = .AsyncFunctionDeclaration(try .init(from: decoder))
            case JSSyntax.BreakStatement.NodeType.BreakStatement.rawValue:
                self = .BreakStatement(try .init(from: decoder))
            case JSSyntax.ContinueStatement.NodeType.ContinueStatement.rawValue:
                self = .ContinueStatement(try .init(from: decoder))
            case JSSyntax.DebuggerStatement.NodeType.DebuggerStatement.rawValue:
                self = .DebuggerStatement(try .init(from: decoder))
            case JSSyntax.DoWhileStatement.NodeType.DoWhileStatement.rawValue:
                self = .DoWhileStatement(try .init(from: decoder))
            case JSSyntax.EmptyStatement.NodeType.EmptyStatement.rawValue:
                self = .EmptyStatement(try .init(from: decoder))
            case JSSyntax.ExpressionStatement.NodeType.ExpressionStatement.rawValue:
                self = .ExpressionStatement(try .init(from: decoder))
            case JSSyntax.Directive.NodeType.Directive.rawValue:
                self = .Directive(try .init(from: decoder))
            case JSSyntax.ForStatement.NodeType.ForStatement.rawValue:
                self = .ForStatement(try .init(from: decoder))
            case JSSyntax.ForInStatement.NodeType.ForInStatement.rawValue:
                self = .ForInStatement(try .init(from: decoder))
            case JSSyntax.ForOfStatement.NodeType.ForOfStatement.rawValue:
                self = .ForOfStatement(try .init(from: decoder))
            case JSSyntax.FunctionDeclaration.NodeType.FunctionDeclaration.rawValue:
                self = .FunctionDeclaration(try .init(from: decoder))
            case JSSyntax.IfStatement.NodeType.IfStatement.rawValue:
                self = .IfStatement(try .init(from: decoder))
            case JSSyntax.LabeledStatement.NodeType.LabeledStatement.rawValue:
                self = .LabeledStatement(try .init(from: decoder))
            case JSSyntax.ReturnStatement.NodeType.ReturnStatement.rawValue:
                self = .ReturnStatement(try .init(from: decoder))
            case JSSyntax.SwitchStatement.NodeType.SwitchStatement.rawValue:
                self = .SwitchStatement(try .init(from: decoder))
            case JSSyntax.ThrowStatement.NodeType.ThrowStatement.rawValue:
                self = .ThrowStatement(try .init(from: decoder))
            case JSSyntax.TryStatement.NodeType.TryStatement.rawValue:
                self = .TryStatement(try .init(from: decoder))
            case JSSyntax.VariableDeclaration.NodeType.VariableDeclaration.rawValue:
                self = .VariableDeclaration(try .init(from: decoder))
            case JSSyntax.WhileStatement.NodeType.WhileStatement.rawValue:
                self = .WhileStatement(try .init(from: decoder))
            case JSSyntax.WithStatement.NodeType.WithStatement.rawValue:
                self = .WithStatement(try .init(from: decoder))
            default:
                throw DecodingError.keyNotFound(CodingKeys.type, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Bad value for type: \(typeName)"))
            }
        }

        public func encode(to encoder: Encoder) throws {
            switch self {
            case .BlockStatement(let x): return try x.encode(to: encoder)
            case .AsyncFunctionDeclaration(let x): return try x.encode(to: encoder)
            case .BreakStatement(let x): return try x.encode(to: encoder)
            case .ContinueStatement(let x): return try x.encode(to: encoder)
            case .DebuggerStatement(let x): return try x.encode(to: encoder)
            case .DoWhileStatement(let x): return try x.encode(to: encoder)
            case .EmptyStatement(let x): return try x.encode(to: encoder)
            case .ExpressionStatement(let x): return try x.encode(to: encoder)
            case .Directive(let x): return try x.encode(to: encoder)
            case .ForStatement(let x): return try x.encode(to: encoder)
            case .ForInStatement(let x): return try x.encode(to: encoder)
            case .ForOfStatement(let x): return try x.encode(to: encoder)
            case .FunctionDeclaration(let x): return try x.encode(to: encoder)
            case .IfStatement(let x): return try x.encode(to: encoder)
            case .LabeledStatement(let x): return try x.encode(to: encoder)
            case .ReturnStatement(let x): return try x.encode(to: encoder)
            case .SwitchStatement(let x): return try x.encode(to: encoder)
            case .ThrowStatement(let x): return try x.encode(to: encoder)
            case .TryStatement(let x): return try x.encode(to: encoder)
            case .VariableDeclaration(let x): return try x.encode(to: encoder)
            case .WhileStatement(let x): return try x.encode(to: encoder)
            case .WithStatement(let x): return try x.encode(to: encoder)
            }
        }

        enum CodingKeys : String, CodingKey {
            case type
        }
    }

    public indirect enum Declaration : Hashable, Codable {
        case AsyncFunctionDeclaration(AsyncFunctionDeclaration)
        case ClassDeclaration(ClassDeclaration)
        case ExportAllDeclaration(ExportAllDeclaration)
        case ExportDefaultDeclaration(ExportDefaultDeclaration)
        case ExportNamedDeclaration(ExportNamedDeclaration)
        case FunctionDeclaration(FunctionDeclaration)
        case ImportDeclaration(ImportDeclaration)
        case VariableDeclaration(VariableDeclaration)

        public init(from decoder: Decoder) throws {
            let typeName = try decoder
                .container(keyedBy: CodingKeys.self)
                .decode(String.self, forKey: .type)

            switch typeName {
            case JSSyntax.AsyncFunctionDeclaration.NodeType.AsyncFunctionDeclaration.rawValue:
                self = .AsyncFunctionDeclaration(try .init(from: decoder))
            case JSSyntax.ClassDeclaration.NodeType.ClassDeclaration.rawValue:
                self = .ClassDeclaration(try .init(from: decoder))
            case JSSyntax.ExportAllDeclaration.NodeType.ExportAllDeclaration.rawValue:
                self = .ExportAllDeclaration(try .init(from: decoder))
            case JSSyntax.ExportDefaultDeclaration.NodeType.ExportDefaultDeclaration.rawValue:
                self = .ExportDefaultDeclaration(try .init(from: decoder))
            case JSSyntax.ExportNamedDeclaration.NodeType.ExportNamedDeclaration.rawValue:
                self = .ExportNamedDeclaration(try .init(from: decoder))
            case JSSyntax.FunctionDeclaration.NodeType.FunctionDeclaration.rawValue:
                self = .FunctionDeclaration(try .init(from: decoder))
            case JSSyntax.ImportDeclaration.NodeType.ImportDeclaration.rawValue:
                self = .ImportDeclaration(try .init(from: decoder))
            case JSSyntax.VariableDeclaration.NodeType.VariableDeclaration.rawValue:
                self = .VariableDeclaration(try .init(from: decoder))
            default:
                throw DecodingError.keyNotFound(CodingKeys.type, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Bad value for type: \(typeName)"))
            }
        }

        public func encode(to encoder: Encoder) throws {
            switch self {
            case .AsyncFunctionDeclaration(let x): return try x.encode(to: encoder)
            case .ClassDeclaration(let x): return try x.encode(to: encoder)
            case .ExportAllDeclaration(let x): return try x.encode(to: encoder)
            case .ExportDefaultDeclaration(let x): return try x.encode(to: encoder)
            case .ExportNamedDeclaration(let x): return try x.encode(to: encoder)
            case .FunctionDeclaration(let x): return try x.encode(to: encoder)
            case .ImportDeclaration(let x): return try x.encode(to: encoder)
            case .VariableDeclaration(let x): return try x.encode(to: encoder)
            }
        }

        enum CodingKeys : String, CodingKey {
            case type
        }
    }


    public typealias ArgumentListElementOneOf = OneOf<Expression>
        .Or<SpreadElement>

    public indirect enum ArgumentListElement : Hashable, Codable {
        case Expression(Expression)
        case SpreadElement(SpreadElement)

        public init(from decoder: Decoder) throws {
            let typeName = try decoder
                .container(keyedBy: CodingKeys.self)
                .decode(String.self, forKey: .type)

            switch typeName {
            case JSSyntax.SpreadElement.NodeType.SpreadElement.rawValue:
                self = .SpreadElement(try .init(from: decoder))
            default:
                self = .Expression(try .init(from: decoder))
            }
        }

        public func encode(to encoder: Encoder) throws {
            switch self {
            case .Expression(let x): return try x.encode(to: encoder)
            case .SpreadElement(let x): return try x.encode(to: encoder)
            }
        }

        enum CodingKeys : String, CodingKey {
            case type
        }
    }

    public typealias ArrayExpressionElementOneOf = Nullable<OneOf<Expression>
       .Or<SpreadElement>>

    public indirect enum ArrayExpressionElement : Hashable, Codable {
        case Expression(Expression)
        case SpreadElement(SpreadElement)

        public init(from decoder: Decoder) throws {
            let typeName = try decoder
                .container(keyedBy: CodingKeys.self)
                .decode(String.self, forKey: .type)

            switch typeName {
            case JSSyntax.SpreadElement.NodeType.SpreadElement.rawValue:
                self = .SpreadElement(try .init(from: decoder))
            default:
                self = .Expression(try .init(from: decoder))
            }
        }

        public func encode(to encoder: Encoder) throws {
            switch self {
            case .Expression(let x): return try x.encode(to: encoder)
            case .SpreadElement(let x): return try x.encode(to: encoder)
            }
        }

        enum CodingKeys : String, CodingKey {
            case type
        }
    }

    public typealias ArrayPatternElement = OneOf<AssignmentPattern>
        .Or<BindingIdentifier>
        .Or<BindingPattern>
        .Or<RestElement>

//    public indirect enum ArrayPatternElement : Hashable, Codable {
//        case AssignmentPattern(AssignmentPattern)
//        case BindingIdentifier(BindingIdentifier)
//        case BindingPattern(BindingPattern)
//        case RestElement(RestElement)
//
//        public init(from decoder: Decoder) throws {
//            let typeName = try decoder
//                .container(keyedBy: CodingKeys.self)
//                .decode(String.self, forKey: .type)
//
//            switch typeName {
//            case JSSyntax.AssignmentPattern.NodeType.AssignmentPattern.rawValue:
//                self = .AssignmentPattern(try .init(from: decoder))
//            case JSSyntax.BindingIdentifier.NodeType.BindingIdentifier.rawValue:
//                self = .BindingIdentifier(try .init(from: decoder))
//            case JSSyntax.BindingPattern.NodeType.BindingPattern.rawValue:
//                self = .BindingPattern(try .init(from: decoder))
//            case JSSyntax.RestElement.NodeType.RestElement.rawValue:
//                self = .RestElement(try .init(from: decoder))
//            default:
//                throw DecodingError.keyNotFound(CodingKeys.type, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Bad value for type: \(typeName)"))
//            }
//        }
//
//        public func encode(to encoder: Encoder) throws {
//            switch self {
//            case .AssignmentPattern(let x): return try x.encode(to: encoder)
//            case .BindingIdentifier(let x): return try x.encode(to: encoder)
//            case .BindingPattern(let x): return try x.encode(to: encoder)
//            case .RestElement(let x): return try x.encode(to: encoder)
//            }
//        }
//
//        enum CodingKeys : String, CodingKey {
//            case type
//        }
//    }

    public typealias BindingPatternOneOf = OneOf<ArrayPattern>
        .Or<ObjectPattern>

    public indirect enum BindingPattern : Hashable, Codable {
        case ArrayPattern(ArrayPattern)
        case ObjectPattern(ObjectPattern)

        public init(from decoder: Decoder) throws {
            let typeName = try decoder
                .container(keyedBy: CodingKeys.self)
                .decode(String.self, forKey: .type)

            switch typeName {
            case JSSyntax.ArrayPattern.NodeType.ArrayPattern.rawValue:
                self = .ArrayPattern(try .init(from: decoder))
            case JSSyntax.ObjectPattern.NodeType.ObjectPattern.rawValue:
                self = .ObjectPattern(try .init(from: decoder))
            default:
                throw DecodingError.keyNotFound(CodingKeys.type, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Bad value for type: \(typeName)"))
            }
        }

        public func encode(to encoder: Encoder) throws {
            switch self {
            case .ArrayPattern(let x): return try x.encode(to: encoder)
            case .ObjectPattern(let x): return try x.encode(to: encoder)
            }
        }

        enum CodingKeys : String, CodingKey {
            case type
        }
    }

    public typealias BindingIdentifier = Identifier

    public typealias ChainElementOneOf = OneOf<CallExpression>
        .Or<ComputedMemberExpression>
        .Or<StaticMemberExpression>


    public indirect enum ChainElement : Hashable, Codable {
        case CallExpression(CallExpression)
        case ComputedMemberExpression(ComputedMemberExpression)
        case StaticMemberExpression(StaticMemberExpression)

        public init(from decoder: Decoder) throws {
            let typeName = try decoder
                .container(keyedBy: CodingKeys.self)
                .decode(String.self, forKey: .type)

            switch typeName {
            case JSSyntax.CallExpression.NodeType.CallExpression.rawValue:
                self = .CallExpression(try .init(from: decoder))
            case JSSyntax.ComputedMemberExpression.NodeType.ComputedMemberExpression.rawValue:
                self = .ComputedMemberExpression(try .init(from: decoder))
            case JSSyntax.StaticMemberExpression.NodeType.StaticMemberExpression.rawValue:
                self = .StaticMemberExpression(try .init(from: decoder))
            default:
                throw DecodingError.keyNotFound(CodingKeys.type, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Bad value for type: \(typeName)"))
            }
        }

        public func encode(to encoder: Encoder) throws {
            switch self {
            case .CallExpression(let x): return try x.encode(to: encoder)
            case .ComputedMemberExpression(let x): return try x.encode(to: encoder)
            case .StaticMemberExpression(let x): return try x.encode(to: encoder)
            }
        }

        enum CodingKeys : String, CodingKey {
            case type
        }
    }

    public typealias ExportableDefaultDeclaration = OneOf<BindingIdentifier>
        .Or<BindingPattern>
        .Or<ClassDeclaration>
        .Or<Expression>
        .Or<FunctionDeclaration>

//    public indirect enum ExportableDefaultDeclaration : Hashable, Codable {
//        case BindingIdentifier(BindingIdentifier)
//        case BindingPattern(BindingPattern)
//        case ClassDeclaration(ClassDeclaration)
//        case Expression(Expression)
//        case FunctionDeclaration(FunctionDeclaration)
//
//        public init(from decoder: Decoder) throws {
//            let typeName = try decoder
//                .container(keyedBy: CodingKeys.self)
//                .decode(String.self, forKey: .type)
//
//            switch typeName {
//            case JSSyntax.BindingIdentifier.NodeType.BindingIdentifier.rawValue:
//                self = .BindingIdentifier(try .init(from: decoder))
//            case JSSyntax.BindingPattern.NodeType.BindingPattern.rawValue:
//                self = .BindingPattern(try .init(from: decoder))
//            case JSSyntax.ClassDeclaration.NodeType.ClassDeclaration.rawValue:
//                self = .ClassDeclaration(try .init(from: decoder))
//            case JSSyntax.Expression.NodeType.Expression.rawValue:
//                self = .Expression(try .init(from: decoder))
//            case JSSyntax.FunctionDeclaration.NodeType.FunctionDeclaration.rawValue:
//                self = .FunctionDeclaration(try .init(from: decoder))
//            default:
//                throw DecodingError.keyNotFound(CodingKeys.type, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Bad value for type: \(typeName)"))
//            }
//        }
//
//        public func encode(to encoder: Encoder) throws {
//            switch self {
//            case .BindingIdentifier(let x): return try x.encode(to: encoder)
//            case .BindingPattern(let x): return try x.encode(to: encoder)
//            case .ClassDeclaration(let x): return try x.encode(to: encoder)
//            case .Expression(let x): return try x.encode(to: encoder)
//            case .FunctionDeclaration(let x): return try x.encode(to: encoder)
//            }
//        }
//
//        enum CodingKeys : String, CodingKey {
//            case type
//        }
//    }

    public typealias ExportableNamedDeclarationOneOf = OneOf<AsyncFunctionDeclaration>
        .Or<ClassDeclaration>
        .Or<FunctionDeclaration>
        .Or<VariableDeclaration>

    public indirect enum ExportableNamedDeclaration : Hashable, Codable {
        case AsyncFunctionDeclaration(AsyncFunctionDeclaration)
        case ClassDeclaration(ClassDeclaration)
        case FunctionDeclaration(FunctionDeclaration)
        case VariableDeclaration(VariableDeclaration)

        public init(from decoder: Decoder) throws {
            let typeName = try decoder
                .container(keyedBy: CodingKeys.self)
                .decode(String.self, forKey: .type)

            switch typeName {
            case JSSyntax.AsyncFunctionDeclaration.NodeType.AsyncFunctionDeclaration.rawValue:
                self = .AsyncFunctionDeclaration(try .init(from: decoder))
            case JSSyntax.ClassDeclaration.NodeType.ClassDeclaration.rawValue:
                self = .ClassDeclaration(try .init(from: decoder))
            case JSSyntax.FunctionDeclaration.NodeType.FunctionDeclaration.rawValue:
                self = .FunctionDeclaration(try .init(from: decoder))
            case JSSyntax.VariableDeclaration.NodeType.VariableDeclaration.rawValue:
                self = .VariableDeclaration(try .init(from: decoder))
            default:
                throw DecodingError.keyNotFound(CodingKeys.type, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Bad value for type: \(typeName)"))
            }
        }

        public func encode(to encoder: Encoder) throws {
            switch self {
            case .AsyncFunctionDeclaration(let x): return try x.encode(to: encoder)
            case .ClassDeclaration(let x): return try x.encode(to: encoder)
            case .FunctionDeclaration(let x): return try x.encode(to: encoder)
            case .VariableDeclaration(let x): return try x.encode(to: encoder)
            }
        }

        enum CodingKeys : String, CodingKey {
            case type
        }
    }

    public typealias ExportDeclarationOneOf = OneOf<ExportAllDeclaration>
        .Or<ExportDefaultDeclaration>
        .Or<ExportNamedDeclaration>

    public indirect enum ExportDeclaration : Hashable, Codable {
        case ExportAllDeclaration(ExportAllDeclaration)
        case ExportDefaultDeclaration(ExportDefaultDeclaration)
        case ExportNamedDeclaration(ExportNamedDeclaration)

        public init(from decoder: Decoder) throws {
            let typeName = try decoder
                .container(keyedBy: CodingKeys.self)
                .decode(String.self, forKey: .type)

            switch typeName {
            case JSSyntax.ExportAllDeclaration.NodeType.ExportAllDeclaration.rawValue:
                self = .ExportAllDeclaration(try .init(from: decoder))
            case JSSyntax.ExportDefaultDeclaration.NodeType.ExportDefaultDeclaration.rawValue:
                self = .ExportDefaultDeclaration(try .init(from: decoder))
            case JSSyntax.ExportNamedDeclaration.NodeType.ExportNamedDeclaration.rawValue:
                self = .ExportNamedDeclaration(try .init(from: decoder))
            default:
                throw DecodingError.keyNotFound(CodingKeys.type, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Bad value for type: \(typeName)"))
            }
        }

        public func encode(to encoder: Encoder) throws {
            switch self {
            case .ExportAllDeclaration(let x): return try x.encode(to: encoder)
            case .ExportDefaultDeclaration(let x): return try x.encode(to: encoder)
            case .ExportNamedDeclaration(let x): return try x.encode(to: encoder)
            }
        }

        enum CodingKeys : String, CodingKey {
            case type
        }
    }

    public typealias FunctionParameter = OneOf<AssignmentPattern>
        .Or<BindingIdentifier>
        .Or<BindingPattern>

//    public indirect enum FunctionParameter : Hashable, Codable {
//        case AssignmentPattern(AssignmentPattern)
//        case BindingIdentifier(BindingIdentifier)
//        case BindingPattern(BindingPattern)
//
//        public init(from decoder: Decoder) throws {
//            let typeName = try decoder
//                .container(keyedBy: CodingKeys.self)
//                .decode(String.self, forKey: .type)
//
//            switch typeName {
//            case JSSyntax.AssignmentPattern.NodeType.AssignmentPattern.rawValue:
//                self = .AssignmentPattern(try .init(from: decoder))
//            case JSSyntax.BindingIdentifier.NodeType.BindingIdentifier.rawValue:
//                self = .BindingIdentifier(try .init(from: decoder))
//            case JSSyntax.BindingPattern.NodeType.BindingPattern.rawValue:
//                self = .BindingPattern(try .init(from: decoder))
//            default:
//                throw DecodingError.keyNotFound(CodingKeys.type, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Bad value for type: \(typeName)"))
//            }
//        }
//
//        public func encode(to encoder: Encoder) throws {
//            switch self {
//            case .AssignmentPattern(let x): return try x.encode(to: encoder)
//            case .BindingIdentifier(let x): return try x.encode(to: encoder)
//            case .BindingPattern(let x): return try x.encode(to: encoder)
//            }
//        }
//
//        enum CodingKeys : String, CodingKey {
//            case type
//        }
//    }

    public typealias ImportDeclarationSpecifierOneOf = OneOf<ImportDefaultSpecifier>
        .Or<ImportNamespaceSpecifier>
        .Or<ImportSpecifier>

    public indirect enum ImportDeclarationSpecifier : Hashable, Codable {
        case ImportDefaultSpecifier(ImportDefaultSpecifier)
        case ImportNamespaceSpecifier(ImportNamespaceSpecifier)
        case ImportSpecifier(ImportSpecifier)

        public init(from decoder: Decoder) throws {
            let typeName = try decoder
                .container(keyedBy: CodingKeys.self)
                .decode(String.self, forKey: .type)

            switch typeName {
            case JSSyntax.ImportDefaultSpecifier.NodeType.ImportDefaultSpecifier.rawValue:
                self = .ImportDefaultSpecifier(try .init(from: decoder))
            case JSSyntax.ImportNamespaceSpecifier.NodeType.ImportNamespaceSpecifier.rawValue:
                self = .ImportNamespaceSpecifier(try .init(from: decoder))
            case JSSyntax.ImportSpecifier.NodeType.ImportSpecifier.rawValue:
                self = .ImportSpecifier(try .init(from: decoder))
            default:
                throw DecodingError.keyNotFound(CodingKeys.type, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Bad value for type: \(typeName)"))
            }
        }

        public func encode(to encoder: Encoder) throws {
            switch self {
            case .ImportDefaultSpecifier(let x): return try x.encode(to: encoder)
            case .ImportNamespaceSpecifier(let x): return try x.encode(to: encoder)
            case .ImportSpecifier(let x): return try x.encode(to: encoder)
            }
        }

        enum CodingKeys : String, CodingKey {
            case type
        }
    }

    public typealias ObjectExpressionPropertyOneOf = OneOf<Property>
        .Or<SpreadElement>

    public indirect enum ObjectExpressionProperty : Hashable, Codable {
        case Property(Property)
        case SpreadElement(SpreadElement)

        public init(from decoder: Decoder) throws {
            let typeName = try decoder
                .container(keyedBy: CodingKeys.self)
                .decode(String.self, forKey: .type)

            switch typeName {
            case JSSyntax.Property.NodeType.Property.rawValue:
                self = .Property(try .init(from: decoder))
            case JSSyntax.SpreadElement.NodeType.SpreadElement.rawValue:
                self = .SpreadElement(try .init(from: decoder))
            default:
                throw DecodingError.keyNotFound(CodingKeys.type, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Bad value for type: \(typeName)"))
            }
        }

        public func encode(to encoder: Encoder) throws {
            switch self {
            case .Property(let x): return try x.encode(to: encoder)
            case .SpreadElement(let x): return try x.encode(to: encoder)
            }
        }

        enum CodingKeys : String, CodingKey {
            case type
        }
    }

    public typealias ObjectPatternPropertyOneOf = OneOf<Property>
        .Or<RestElement>

    public indirect enum ObjectPatternProperty : Hashable, Codable {
        case Property(Property)
        case RestElement(RestElement)

        public init(from decoder: Decoder) throws {
            let typeName = try decoder
                .container(keyedBy: CodingKeys.self)
                .decode(String.self, forKey: .type)

            switch typeName {
            case JSSyntax.Property.NodeType.Property.rawValue:
                self = .Property(try .init(from: decoder))
            case JSSyntax.RestElement.NodeType.RestElement.rawValue:
                self = .RestElement(try .init(from: decoder))
            default:
                throw DecodingError.keyNotFound(CodingKeys.type, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Bad value for type: \(typeName)"))
            }
        }

        public func encode(to encoder: Encoder) throws {
            switch self {
            case .Property(let x): return try x.encode(to: encoder)
            case .RestElement(let x): return try x.encode(to: encoder)
            }
        }

        enum CodingKeys : String, CodingKey {
            case type
        }
    }

    public typealias PropertyKeyOneOf = OneOf<Identifier>
        .Or<Literal>

    public indirect enum PropertyKey : Hashable, Codable {
        case Identifier(Identifier)
        case Literal(Literal)

        public init(from decoder: Decoder) throws {
            let typeName = try decoder
                .container(keyedBy: CodingKeys.self)
                .decode(String.self, forKey: .type)

            switch typeName {
            case JSSyntax.Identifier.NodeType.Identifier.rawValue:
                self = .Identifier(try .init(from: decoder))
            case JSSyntax.Literal.NodeType.Literal.rawValue:
                self = .Literal(try .init(from: decoder))
            default:
                throw DecodingError.keyNotFound(CodingKeys.type, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Bad value for type: \(typeName)"))
            }
        }

        public func encode(to encoder: Encoder) throws {
            switch self {
            case .Identifier(let x): return try x.encode(to: encoder)
            case .Literal(let x): return try x.encode(to: encoder)
            }
        }

        enum CodingKeys : String, CodingKey {
            case type
        }
    }

    public typealias StatementListItem = OneOf<Declaration>
        .Or<Statement>

//    public indirect enum StatementListItem : Hashable, Codable {
//        case Declaration(Declaration)
//        case Statement(Statement)
//
//        public init(from decoder: Decoder) throws {
//            let typeName = try decoder
//                .container(keyedBy: CodingKeys.self)
//                .decode(String.self, forKey: .type)
//
//            switch typeName {
//            case JSSyntax.Declaration.NodeType.Declaration.rawValue:
//                self = .Declaration(try .init(from: decoder))
//            case JSSyntax.Statement.NodeType.Statement.rawValue:
//                self = .Statement(try .init(from: decoder))
//            default:
//                throw DecodingError.keyNotFound(CodingKeys.type, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Bad value for type: \(typeName)"))
//            }
//        }
//
//        public func encode(to encoder: Encoder) throws {
//            switch self {
//            case .Declaration(let x): return try x.encode(to: encoder)
//            case .Statement(let x): return try x.encode(to: encoder)
//            }
//        }
//
//        enum CodingKeys : String, CodingKey {
//            case type
//        }
//    }

    public typealias ModuleItem = OneOf<ImportDeclaration>
        .Or<ExportDeclaration>
        .Or<StatementListItem>

//    public indirect enum ModuleItem : Hashable, Codable {
//        case ImportDeclaration(ImportDeclaration)
//        case ExportDeclaration(ExportDeclaration)
//        case StatementListItem(StatementListItem)
//
//        public init(from decoder: Decoder) throws {
//            let typeName = try decoder
//                .container(keyedBy: CodingKeys.self)
//                .decode(String.self, forKey: .type)
//
//            switch typeName {
//            case JSSyntax.ImportDeclaration.NodeType.ImportDeclaration.rawValue:
//                self = .ImportDeclaration(try .init(from: decoder))
//            case JSSyntax.ExportDeclaration.NodeType.ExportDeclaration.rawValue:
//                self = .ExportDeclaration(try .init(from: decoder))
//            case JSSyntax.StatementListItem.NodeType.StatementListItem.rawValue:
//                self = .StatementListItem(try .init(from: decoder))
//            default:
//                throw DecodingError.keyNotFound(CodingKeys.type, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Bad value for type: \(typeName)"))
//            }
//        }
//
//        public func encode(to encoder: Encoder) throws {
//            switch self {
//            case .ImportDeclaration(let x): return try x.encode(to: encoder)
//            case .ExportDeclaration(let x): return try x.encode(to: encoder)
//            case .StatementListItem(let x): return try x.encode(to: encoder)
//            }
//        }
//
//        enum CodingKeys : String, CodingKey {
//            case type
//        }
//    }

}

@available(*, deprecated, message: "Prefer custom enums over OneOf for performance")
extension JSSyntax {

    public typealias StatementOneOf = OneOf<BlockStatement>
        .Or<AsyncFunctionDeclaration>
        .Or<BreakStatement>
        .Or<ContinueStatement>
        .Or<DebuggerStatement>
        .Or<DoWhileStatement>
        .Or<EmptyStatement>
        .Or<ExpressionStatement>
        .Or<Directive>
        .Or<ForStatement>
        .Or<ForInStatement>
        .Or<ForOfStatement>
        .Or<FunctionDeclaration>
        .Or<IfStatement>
        .Or<LabeledStatement>
        .Or<ReturnStatement>
        .Or<SwitchStatement>
        .Or<ThrowStatement>
        .Or<TryStatement>
        .Or<VariableDeclaration>
        .Or<WhileStatement>
        .Or<WithStatement>


    public typealias ExpressionOneOf = OneOf<ThisExpression>
        .Or<Identifier>
        .Or<Literal>
        .Or<SequenceExpression>
        .Or<ArrayExpression>
        .Or<MemberExpression>
        .Or<MetaProperty>
        .Or<CallExpression>
        .Or<ObjectExpression>
        .Or<FunctionExpression>
        .Or<ArrowFunctionExpression>
        .Or<ClassExpression>
        .Or<TaggedTemplateExpression>
        .Or<Super>
        .Or<NewExpression>
        .Or<UpdateExpression>
        .Or<AwaitExpression>
        .Or<UnaryExpression>
        .Or<BinaryExpression>
        .Or<LogicalExpression>
        .Or<ConditionalExpression>
        .Or<YieldExpression>
        .Or<AssignmentExpression>
        .Or<AsyncArrowFunctionExpression>
        .Or<AsyncFunctionExpression>
        .Or<ChainExpression>
        .Or<RegexLiteral>

    public typealias DeclarationOneOf = OneOf<AsyncFunctionDeclaration>
        .Or<ClassDeclaration>
        .Or<ExportDeclaration>
        .Or<FunctionDeclaration>
        .Or<ImportDeclaration>
        .Or<VariableDeclaration>

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
    case LineComment = "LineComment"
}


// MARK: tokenizer.ts

public struct Regex : Hashable, Codable {
    public var pattern: String
    public var flags: String
}

/// A lexical token from a JS program or fragment
public struct JSToken : Hashable, Codable {
    public var type: JSTokenType
    public var value: String
    public var regex: Regex?
    public var range: ClosedRange<Int>?
    public var loc: SourceLocation?
}

typealias BufferEntry = JSToken

struct Config : Hashable, Codable {
    let tolerant: Bool?
    let comment: Bool?
    let range: Bool?
    let loc: Bool?
}


// MARK: error-handler.ts

public struct JSSyntaxError : Error {
    public private(set) var name: String;
    public private(set) var message: String;
    public private(set) var index: Int;
    public private(set) var lineNumber: Int;
    public private(set) var column: Int;
    public private(set) var description: Messages;
}

class ErrorHandler {
    var errors: [JSSyntaxError];
    var tolerant: Bool;

    init() {
        self.errors = [];
        self.tolerant = false;
    }

    func recordError(error: JSSyntaxError) {
        self.errors.append(error);
    }

    func tolerate(error: JSSyntaxError) throws {
        if (self.tolerant) {
            self.recordError(error: error);
        } else {
            throw error;
        }
    }

    func createError(index: Int, line: Int, col: Int, description: Messages) -> JSSyntaxError {
        JSSyntaxError(name: "", message: "Line \(line): \(description)", index: index, lineNumber: line, column: col, description: description)
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
    public init(line: Int? = nil, column: Int? = nil) {
        self.line = line
        self.column = column
    }

    public var line: Int?
    public var column: Int?
}

public struct SourceLocation : Hashable, Codable {
    public init(start: Position, end: Position, source: String? = nil) {
        self.start = start
        self.end = end
        self.source = source
    }

    public var start: Position
    public var end: Position
    public var source: String? = nil
}


extension Never : JSSyntaxNodeType {
    public var typeName: String { fatalError("never") }
}

extension OneOf2 : JSSyntaxNodeType where T1: JSSyntaxNodeType, T2: JSSyntaxNodeType {
    public var typeName: String { expanded.typeName }
}

extension OneOf3 : JSSyntaxNodeType where T1: JSSyntaxNodeType, T2: JSSyntaxNodeType, T3: JSSyntaxNodeType {
    public var typeName: String { expanded.typeName }
}

extension OneOf4 : JSSyntaxNodeType where T1: JSSyntaxNodeType, T2: JSSyntaxNodeType, T3: JSSyntaxNodeType, T4: JSSyntaxNodeType {
    public var typeName: String { expanded.typeName }
}

extension OneOf5 : JSSyntaxNodeType where T1: JSSyntaxNodeType, T2: JSSyntaxNodeType, T3: JSSyntaxNodeType, T4: JSSyntaxNodeType, T5: JSSyntaxNodeType {
    public var typeName: String { expanded.typeName }
}

extension OneOf6 : JSSyntaxNodeType where T1: JSSyntaxNodeType, T2: JSSyntaxNodeType, T3: JSSyntaxNodeType, T4: JSSyntaxNodeType, T5: JSSyntaxNodeType, T6: JSSyntaxNodeType {
    public var typeName: String { expanded.typeName }
}

extension OneOf7 : JSSyntaxNodeType where T1: JSSyntaxNodeType, T2: JSSyntaxNodeType, T3: JSSyntaxNodeType, T4: JSSyntaxNodeType, T5: JSSyntaxNodeType, T6: JSSyntaxNodeType, T7: JSSyntaxNodeType {
    public var typeName: String { expanded.typeName }
}

extension OneOf8 : JSSyntaxNodeType where T1: JSSyntaxNodeType, T2: JSSyntaxNodeType, T3: JSSyntaxNodeType, T4: JSSyntaxNodeType, T5: JSSyntaxNodeType, T6: JSSyntaxNodeType, T7: JSSyntaxNodeType, T8: JSSyntaxNodeType {
    public var typeName: String { expanded.typeName }
}

extension OneOf9 : JSSyntaxNodeType where T1: JSSyntaxNodeType, T2: JSSyntaxNodeType, T3: JSSyntaxNodeType, T4: JSSyntaxNodeType, T5: JSSyntaxNodeType, T6: JSSyntaxNodeType, T7: JSSyntaxNodeType, T8: JSSyntaxNodeType, T9: JSSyntaxNodeType {
    public var typeName: String { expanded.typeName }
}

extension OneOf10 : JSSyntaxNodeType where T1: JSSyntaxNodeType, T2: JSSyntaxNodeType, T3: JSSyntaxNodeType, T4: JSSyntaxNodeType, T5: JSSyntaxNodeType, T6: JSSyntaxNodeType, T7: JSSyntaxNodeType, T8: JSSyntaxNodeType, T9: JSSyntaxNodeType, T10: JSSyntaxNodeType {
    public var typeName: String {
        self[routing: (\.typeName, \.typeName, \.typeName, \.typeName, \.typeName, \.typeName, \.typeName, \.typeName, \.typeName, \.typeName)]
    }
}
