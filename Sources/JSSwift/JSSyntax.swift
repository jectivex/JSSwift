
// A JavaScript AST hand-ported from esprima's `syntax.ts`

/// Namespace for nodes corresponding to `Syntax` cases.
///
/// The syntax tree format is derived from the original version of [Mozilla Parser API](https://developer.mozilla.org/en-US/docs/Mozilla/Projects/SpiderMonkey/Parser_API), which is then formalized and expanded as the [ESTree specification](https://github.com/estree/estree).
public enum JSSyntax {

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct Script : JSSyntaxAST {
        public init(type: ProgramNodeType = .Program, body: [StatementListItem], sourceType: String) {
            self.type = type
            self.body = body
            self.sourceType = sourceType
        }

        public var type: ProgramNodeType
        public enum ProgramNodeType : String, Codable { case Program }
        public var body: [StatementListItem]
        public var sourceType: String
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct Module : JSSyntaxAST {
        public init(type: ProgramNodeType = .Program, body: [ModuleItem], sourceType: String) {
            self.type = type
            self.body = body
            self.sourceType = sourceType
        }

        public var type: ProgramNodeType
        public enum ProgramNodeType : String, Codable { case Program }
        public var body: [ModuleItem]
        public var sourceType: String
    }


    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ArrayExpression : JSSyntaxAST {
        public init(type: ArrayExpressionNodeType = .ArrayExpression, elements: Array<ArrayExpressionElement>) {
            self.type = type
            self.elements = elements
        }

        public var type: ArrayExpressionNodeType
        public enum ArrayExpressionNodeType : String, Codable { case ArrayExpression }
        public var elements: Array<ArrayExpressionElement>
    }

    /// https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html#array-pattern
    public struct ArrayPattern : JSSyntaxAST {
        public init(type: ArrayPatternNodeType = .ArrayPattern, elements: [ArrayPatternElement]) {
            self.type = type
            self.elements = elements
        }
        
        public var type: ArrayPatternNodeType
        public enum ArrayPatternNodeType : String, Codable { case ArrayPattern }
        public var elements: [ArrayPatternElement]
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ArrowFunctionExpression : JSSyntaxAST {
        public init(type: ArrowFunctionExpressionNodeType = .ArrowFunctionExpression, id: Nullable<Identifier>, params: [FunctionParameter], body: OneOf<BlockStatement>.Or<Expression>, generator: Bool, expression: Bool, async: Bool) {
            self.type = type
            self.id = id
            self.params = params
            self.body = body
            self.generator = generator
            self.expression = expression
            self.async = async
        }

        public var type: ArrowFunctionExpressionNodeType
        public enum ArrowFunctionExpressionNodeType : String, Codable { case ArrowFunctionExpression }
        public var id: Nullable<Identifier>
        public var params: [FunctionParameter]
        public var body: OneOf<BlockStatement>.Or<Expression>
        public var generator: Bool
        public var expression: Bool
        public var async: Bool
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct AssignmentExpression : JSSyntaxAST {
        public init(type: AssignmentExpressionNodeType = .AssignmentExpression, operator: String, left: Expression, right: Expression) {
            self.type = type
            self.`operator` = `operator`
            self.left = left
            self.right = right
        }

        public var type: AssignmentExpressionNodeType
        public enum AssignmentExpressionNodeType : String, Codable { case AssignmentExpression}
        public var `operator`: String
        public var left: Expression
        public var right: Expression
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct AssignmentPattern : JSSyntaxAST {
        public init(type: AssignmentPatternNodeType = .AssignmentPattern, left: OneOf<BindingIdentifier>.Or<BindingPattern>, right: Expression) {
            self.type = type
            self.left = left
            self.right = right
        }

        public var type: AssignmentPatternNodeType
        public enum AssignmentPatternNodeType : String, Codable { case AssignmentPattern }
        public var left: OneOf<BindingIdentifier>.Or<BindingPattern>
        public var right: Expression
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct AsyncArrowFunctionExpression : JSSyntaxAST {
        public init(type: AsyncArrowFunctionExpressionNodeType = .AsyncArrowFunctionExpression, id: Nullable<Identifier>, params: [FunctionParameter], body: OneOf<BlockStatement>.Or<Expression>, generator: Bool, expression: Bool, async: Bool) {
            self.type = type
            self.id = id
            self.params = params
            self.body = body
            self.generator = generator
            self.expression = expression
            self.async = async
        }

        public var type: AsyncArrowFunctionExpressionNodeType
        public enum AsyncArrowFunctionExpressionNodeType : String, Codable { case AsyncArrowFunctionExpression }
        public var id: Nullable<Identifier>
        public var params: [FunctionParameter]
        public var body: OneOf<BlockStatement>.Or<Expression>
        public var generator: Bool
        public var expression: Bool
        public var async: Bool
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct AsyncFunctionDeclaration : JSSyntaxAST {
        public init(type: AsyncFunctionDeclarationNodeType = .AsyncFunctionDeclaration, id: Nullable<Identifier>, params: [FunctionParameter], body: BlockStatement, generator: Bool, expression: Bool, async: Bool) {
            self.type = type
            self.id = id
            self.params = params
            self.body = body
            self.generator = generator
            self.expression = expression
            self.async = async
        }

        public var type: AsyncFunctionDeclarationNodeType
        public enum AsyncFunctionDeclarationNodeType : String, Codable { case AsyncFunctionDeclaration }
        public var id: Nullable<Identifier>
        public var params: [FunctionParameter]
        public var body: BlockStatement
        public var generator: Bool
        public var expression: Bool
        public var async: Bool
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct AsyncFunctionExpression : JSSyntaxAST {
        public init(type: AsyncFunctionExpressionNodeType = .AsyncFunctionExpression, id: Nullable<Identifier>, params: [FunctionParameter], body: BlockStatement, generator: Bool, expression: Bool, async: Bool) {
            self.type = type
            self.id = id
            self.params = params
            self.body = body
            self.generator = generator
            self.expression = expression
            self.async = async
        }

        public var type: AsyncFunctionExpressionNodeType
        public enum AsyncFunctionExpressionNodeType : String, Codable { case AsyncFunctionExpression }
        public var id: Nullable<Identifier>
        public var params: [FunctionParameter]
        public var body: BlockStatement
        public var generator: Bool
        public var expression: Bool
        public var async: Bool
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct AwaitExpression : JSSyntaxAST {
        public init(type: AwaitExpressionNodeType = .AwaitExpression, argument: Expression) {
            self.type = type
            self.argument = argument
        }

        public var type: AwaitExpressionNodeType
        public enum AwaitExpressionNodeType : String, Codable { case AwaitExpression }
        public var argument: Expression
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct BinaryExpression : JSSyntaxAST {
        public init(type: BinaryExpressionNodeType = .BinaryExpression, `operator`: String, left: Expression, right: Expression) {
            self.type = type
            self.`operator` = `operator`
            self.left = left
            self.right = right
        }

        public var type: BinaryExpressionNodeType
        public enum BinaryExpressionNodeType : String, Codable { case BinaryExpression }
        public var `operator`: String
        public var left: Expression
        public var right: Expression
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct BlockStatement : JSSyntaxAST {
        public init(type: BlockStatementNodeType = .BlockStatement, body: [Statement]) {
            self.type = type
            self.body = body
        }

        public var type: BlockStatementNodeType
        public enum BlockStatementNodeType : String, Codable { case BlockStatement }
        public var body: [Statement]
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct BreakStatement : JSSyntaxAST {
        public init(type: BreakStatementNodeType = .BreakStatement, label: Nullable<Identifier>) {
            self.type = type
            self.label = label
        }

        public var type: BreakStatementNodeType
        public enum BreakStatementNodeType : String, Codable { case BreakStatement }
        public var label: Nullable<Identifier>
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct CallExpression : JSSyntaxAST {
        public init(type: CallExpressionNodeType = .CallExpression, callee: OneOf<Expression>.Or<Import>, arguments: [ArgumentListElement]) {
            self.type = type
            self.callee = callee
            self.arguments = arguments
        }

        public var type: CallExpressionNodeType
        public enum CallExpressionNodeType : String, Codable { case CallExpression }
        public var callee: OneOf<Expression>.Or<Import>
        public var arguments: [ArgumentListElement]
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct CatchClause : JSSyntaxAST {
        public init(type: CatchClauseNodeType = .CatchClause, param: OneOf<BindingIdentifier>.Or<BindingPattern>, body: BlockStatement) {
            self.type = type
            self.param = param
            self.body = body
        }

        public var type: CatchClauseNodeType
        public enum CatchClauseNodeType : String, Codable { case CatchClause }
        public var param: OneOf<BindingIdentifier>.Or<BindingPattern>
        public var body: BlockStatement
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ClassBody : JSSyntaxAST {
        public init(type: ClassBodyNodeType = .ClassBody, body: [Property]) {
            self.type = type
            self.body = body
        }

        public var type: ClassBodyNodeType
        public enum ClassBodyNodeType : String, Codable { case ClassBody }
        public var body: [Property]
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ClassDeclaration : JSSyntaxAST {
        public init(type: ClassDeclarationNodeType = .ClassDeclaration, id: Nullable<Identifier>, superClass: Nullable<Identifier>, body: ClassBody) {
            self.type = type
            self.id = id
            self.superClass = superClass
            self.body = body
        }

        public var type: ClassDeclarationNodeType
        public enum ClassDeclarationNodeType : String, Codable { case ClassDeclaration }
        public var id: Nullable<Identifier>
        public var superClass: Nullable<Identifier>
        public var body: ClassBody
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ClassExpression : JSSyntaxAST {
        public init(type: ClassExpressionNodeType = .ClassExpression, id: Nullable<Identifier>, superClass: Nullable<Identifier>, body: ClassBody) {
            self.type = type
            self.id = id
            self.superClass = superClass
            self.body = body
        }

        public var type: ClassExpressionNodeType
        public enum ClassExpressionNodeType : String, Codable { case ClassExpression }
        public var id: Nullable<Identifier>
        public var superClass: Nullable<Identifier>
        public var body: ClassBody
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ComputedMemberExpression : JSSyntaxAST {
        public init(type: ComputedMemberExpressionNodeType = .ComputedMemberExpression, computed: Bool, object: Expression, property: Expression) {
            self.type = type
            self.computed = computed
            self.object = object
            self.property = property
        }

        public var type: ComputedMemberExpressionNodeType
        public enum ComputedMemberExpressionNodeType : String, Codable { case ComputedMemberExpression }
        public var computed: Bool
        public var object: Expression
        public var property: Expression
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ConditionalExpression : JSSyntaxAST {
        public init(type: ConditionalExpressionNodeType = .ConditionalExpression, test: Expression, consequent: Expression, alternate: Expression) {
            self.type = type
            self.test = test
            self.consequent = consequent
            self.alternate = alternate
        }

        public var type: ConditionalExpressionNodeType
        public enum ConditionalExpressionNodeType : String, Codable { case ConditionalExpression }
        public var test: Expression
        public var consequent: Expression
        public var alternate: Expression
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ContinueStatement : JSSyntaxAST {
        public init(type: ContinueStatementNodeType = .ContinueStatement, label: Nullable<Identifier>) {
            self.type = type
            self.label = label
        }

        public var type: ContinueStatementNodeType
        public enum ContinueStatementNodeType : String, Codable { case ContinueStatement }
        public var label: Nullable<Identifier>
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct DebuggerStatement : JSSyntaxAST {
        public init(type: DebuggerStatementNodeType = .DebuggerStatement) {
            self.type = type
        }

        public var type: DebuggerStatementNodeType
        public enum DebuggerStatementNodeType : String, Codable { case DebuggerStatement }
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct Directive : JSSyntaxAST {
        public init(type: DirectiveNodeType = .Directive, expression: Expression, directive: String) {
            self.type = type
            self.expression = expression
            self.directive = directive
        }

        public var type: DirectiveNodeType
        public enum DirectiveNodeType : String, Codable { case Directive }
        public var expression: Expression
        public var directive: String
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct DoWhileStatement : JSSyntaxAST {
        public init(type: DoWhileStatementNodeType = .DoWhileStatement, body: Statement, test: Expression) {
            self.type = type
            self.body = body
            self.test = test
        }

        public var type: DoWhileStatementNodeType
        public enum DoWhileStatementNodeType : String, Codable { case DoWhileStatement }
        public var body: Statement
        public var test: Expression
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct EmptyStatement : JSSyntaxAST {
        public init(type: EmptyStatementNodeType = .EmptyStatement) {
            self.type = type
        }

        public var type: EmptyStatementNodeType
        public enum EmptyStatementNodeType : String, Codable { case EmptyStatement }
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ExportAllDeclaration : JSSyntaxAST {
        public init(type: ExportAllDeclarationNodeType = .ExportAllDeclaration, source: Literal) {
            self.type = type
            self.source = source
        }

        public var type: ExportAllDeclarationNodeType
        public enum ExportAllDeclarationNodeType : String, Codable { case ExportAllDeclaration }
        public var source: Literal
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ExportDefaultDeclaration : JSSyntaxAST {
        public init(type: ExportDefaultDeclarationNodeType = .ExportDefaultDeclaration, declaration: ExportableDefaultDeclaration) {
            self.type = type
            self.declaration = declaration
        }

        public var type: ExportDefaultDeclarationNodeType
        public enum ExportDefaultDeclarationNodeType : String, Codable { case ExportDefaultDeclaration }
        public var declaration: ExportableDefaultDeclaration
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ExportNamedDeclaration : JSSyntaxAST {
        public init(type: ExportNamedDeclarationNodeType = .ExportNamedDeclaration, declaration: Nullable<ExportableNamedDeclaration>, specifiers: [ExportSpecifier], source: Nullable<Literal>) {
            self.type = type
            self.declaration = declaration
            self.specifiers = specifiers
            self.source = source
        }

        public var type: ExportNamedDeclarationNodeType
        public enum ExportNamedDeclarationNodeType : String, Codable { case ExportNamedDeclaration }
        public var declaration: Nullable<ExportableNamedDeclaration>
        public var specifiers: [ExportSpecifier]
        public var source: Nullable<Literal>
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ExportSpecifier : JSSyntaxAST {
        public init(type: ExportSpecifierNodeType = .ExportSpecifier, exported: Identifier, local: Identifier) {
            self.type = type
            self.exported = exported
            self.local = local
        }

        public var type: ExportSpecifierNodeType
        public enum ExportSpecifierNodeType : String, Codable { case ExportSpecifier }
        public var exported: Identifier
        public var local: Identifier
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ExpressionStatement : JSSyntaxAST {
        public init(type: ExpressionStatementNodeType = .ExpressionStatement, expression: Expression) {
            self.type = type
            self.expression = expression
        }

        public var type: ExpressionStatementNodeType
        public enum ExpressionStatementNodeType : String, Codable { case ExpressionStatement }
        public var expression: Expression
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ForInStatement : JSSyntaxAST {
        public init(type: ForInStatementNodeType = .ForInStatement, left: Expression, right: Expression, body: Statement, each: Bool) {
            self.type = type
            self.left = left
            self.right = right
            self.body = body
            self.each = each
        }

        public var type: ForInStatementNodeType
        public enum ForInStatementNodeType : String, Codable { case ForInStatement }
        public var left: Expression
        public var right: Expression
        public var body: Statement
        public var each: Bool
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ForOfStatement : JSSyntaxAST {
        public init(type: ForOfStatementNodeType = .ForOfStatement, left: Expression, right: Expression, body: Statement) {
            self.type = type
            self.left = left
            self.right = right
            self.body = body
        }

        public var type: ForOfStatementNodeType
        public enum ForOfStatementNodeType : String, Codable { case ForOfStatement }
        public var left: Expression
        public var right: Expression
        public var body: Statement
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ForStatement : JSSyntaxAST {
        public init(type: ForStatementNodeType = .ForStatement, `init`: Nullable<Expression>, test: Nullable<Expression>, update: Nullable<Expression>, body: Statement) {
            self.type = type
            self.`init` = `init`
            self.test = test
            self.update = update
            self.body = body
        }

        public var type: ForStatementNodeType
        public enum ForStatementNodeType : String, Codable { case ForStatement }
        public var `init`: Nullable<Expression>
        public var test: Nullable<Expression>
        public var update: Nullable<Expression>
        public var body: Statement
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct FunctionDeclaration : JSSyntaxAST {
        public init(type: FunctionDeclarationNodeType = .FunctionDeclaration, id: Nullable<Identifier>, params: [FunctionParameter], body: BlockStatement, generator: Bool, expression: Bool, async: Bool) {
            self.type = type
            self.id = id
            self.params = params
            self.body = body
            self.generator = generator
            self.expression = expression
            self.async = async
        }

        public var type: FunctionDeclarationNodeType
        public enum FunctionDeclarationNodeType : String, Codable { case FunctionDeclaration }
        public var id: Nullable<Identifier>
        public var params: [FunctionParameter]
        public var body: BlockStatement
        public var generator: Bool
        public var expression: Bool
        public var async: Bool
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct FunctionExpression : JSSyntaxAST {
        public init(type: FunctionExpressionNodeType = .FunctionExpression, id: Nullable<Identifier>, params: [FunctionParameter], body: BlockStatement, generator: Bool, expression: Bool, async: Bool) {
            self.type = type
            self.id = id
            self.params = params
            self.body = body
            self.generator = generator
            self.expression = expression
            self.async = async
        }

        public var type: FunctionExpressionNodeType
        public enum FunctionExpressionNodeType : String, Codable { case FunctionExpression }
        public var id: Nullable<Identifier>
        public var params: [FunctionParameter]
        public var body: BlockStatement
        public var generator: Bool
        public var expression: Bool
        public var async: Bool
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct Identifier : JSSyntaxAST {
        public init(type: IdentifierNodeType = .Identifier, name: String) {
            self.type = type
            self.name = name
        }

        public var type: IdentifierNodeType
        public enum IdentifierNodeType : String, Codable { case Identifier }
        public var name: String
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct IfStatement : JSSyntaxAST {
        public init(type: IfStatementNodeType = .IfStatement, test: Expression, consequent: Statement, alternate: Nullable<Statement>) {
            self.type = type
            self.test = test
            self.consequent = consequent
            self.alternate = alternate
        }

        public var type: IfStatementNodeType
        public enum IfStatementNodeType : String, Codable { case IfStatement }
        public var test: Expression
        public var consequent: Statement
        public var alternate: Nullable<Statement>
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct Import : JSSyntaxAST {
        public init(type: ImportNodeType = .Import) {
            self.type = type
        }

        public var type: ImportNodeType
        public enum ImportNodeType : String, Codable { case Import }
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ImportDeclaration : JSSyntaxAST {
        public init(type: ImportDeclarationNodeType = .ImportDeclaration, specifiers: [ImportDeclarationSpecifier], source: Literal) {
            self.type = type
            self.specifiers = specifiers
            self.source = source
        }

        public var type: ImportDeclarationNodeType
        public enum ImportDeclarationNodeType : String, Codable { case ImportDeclaration }
        public var specifiers: [ImportDeclarationSpecifier]
        public var source: Literal
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ImportDefaultSpecifier : JSSyntaxAST {
        public init(type: ImportDefaultSpecifierNodeType = .ImportDefaultSpecifier, local: Identifier) {
            self.type = type
            self.local = local
        }

        public var type: ImportDefaultSpecifierNodeType
        public enum ImportDefaultSpecifierNodeType : String, Codable { case ImportDefaultSpecifier }
        public var local: Identifier
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ImportNamespaceSpecifier : JSSyntaxAST {
        public init(type: ImportNamespaceSpecifierNodeType = .ImportNamespaceSpecifier, local: Identifier) {
            self.type = type
            self.local = local
        }

        public var type: ImportNamespaceSpecifierNodeType
        public enum ImportNamespaceSpecifierNodeType : String, Codable { case ImportNamespaceSpecifier }
        public var local: Identifier
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ImportSpecifier : JSSyntaxAST {
        public init(type: ImportSpecifierNodeType = .ImportSpecifier, local: Identifier, imported: Identifier) {
            self.type = type
            self.local = local
            self.imported = imported
        }

        public var type: ImportSpecifierNodeType
        public enum ImportSpecifierNodeType : String, Codable { case ImportSpecifier }
        public var local: Identifier
        public var imported: Identifier
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct LabeledStatement : JSSyntaxAST {
        public init(type: LabeledStatementNodeType = .LabeledStatement, label: Identifier, body: Statement) {
            self.type = type
            self.label = label
            self.body = body
        }

        public var type: LabeledStatementNodeType
        public enum LabeledStatementNodeType : String, Codable { case LabeledStatement }
        public var label: Identifier
        public var body: Statement
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct Literal : JSSyntaxAST {
        public init(type: LiteralNodeType = .Literal, value: OneOf<Bool>.Or<Double>.Or<String>.Or<ExplicitNull>, raw: String) {
            self.type = type
            self.value = value
            self.raw = raw
        }

        public var type: LiteralNodeType
        public enum LiteralNodeType : String, Codable { case Literal }
        public var value: OneOf<Bool>.Or<Double>.Or<String>.Or<ExplicitNull>
        public var raw: String
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct MetaProperty : JSSyntaxAST {
        public init(type: MetaPropertyNodeType = .MetaProperty, meta: Identifier, property: Identifier) {
            self.type = type
            self.meta = meta
            self.property = property
        }

        public var type: MetaPropertyNodeType
        public enum MetaPropertyNodeType : String, Codable { case MetaProperty }
        public var meta: Identifier
        public var property: Identifier
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct MethodDefinition : JSSyntaxAST {
        public init(type: MethodDefinitionNodeType = .MethodDefinition, key: Nullable<Expression>, computed: Bool, value: OneOf<AsyncFunctionExpression>.Or<FunctionExpression>.Or<ExplicitNull>, kind: String, `static`: Bool) {
            self.type = type
            self.key = key
            self.computed = computed
            self.value = value
            self.kind = kind
            self.`static` = `static`
        }

        public var type: MethodDefinitionNodeType
        public enum MethodDefinitionNodeType : String, Codable { case MethodDefinition }
        public var key: Nullable<Expression>
        public var computed: Bool
        public var value: OneOf<AsyncFunctionExpression>.Or<FunctionExpression>.Or<ExplicitNull>
        public var kind: String
        public var `static`: Bool
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct NewExpression : JSSyntaxAST {
        public init(type: NewExpressionNodeType = .NewExpression, callee: Expression, arguments: [ArgumentListElement]) {
            self.type = type
            self.callee = callee
            self.arguments = arguments
        }

        public var type: NewExpressionNodeType
        public enum NewExpressionNodeType : String, Codable { case NewExpression }
        public var callee: Expression
        public var arguments: [ArgumentListElement]
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ObjectExpression : JSSyntaxAST {
        public init(type: ObjectExpressionNodeType = .ObjectExpression, properties: [ObjectExpressionProperty]) {
            self.type = type
            self.properties = properties
        }

        public var type: ObjectExpressionNodeType
        public enum ObjectExpressionNodeType : String, Codable { case ObjectExpression }
        public var properties: [ObjectExpressionProperty]
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ObjectPattern : JSSyntaxAST {
        public init(type: ObjectPatternNodeType = .ObjectPattern, properties: [ObjectPatternProperty]) {
            self.type = type
            self.properties = properties
        }

        public var type: ObjectPatternNodeType
        public enum ObjectPatternNodeType : String, Codable { case ObjectPattern }
        public var properties: [ObjectPatternProperty]
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct Property : JSSyntaxAST {
        public init(type: PropertyNodeType = .Property, key: PropertyKey, computed: Bool, value: Nullable<PropertyValue>, kind: String, method: Bool, shorthand: Bool) {
            self.type = type
            self.key = key
            self.computed = computed
            self.value = value
            self.kind = kind
            self.method = method
            self.shorthand = shorthand
        }

        public var type: PropertyNodeType
        public enum PropertyNodeType : String, Codable { case Property }
        public var key: PropertyKey
        public var computed: Bool
        public var value: Nullable<PropertyValue>
        public var kind: String
        public var method: Bool
        public var shorthand: Bool
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct RegexLiteral : JSSyntaxAST {
        public init(type: RegexLiteralNodeType = .RegexLiteral, value: Bric, raw: String, regex: Regex) {
            self.type = type
            self.value = value
            self.raw = raw
            self.regex = regex
        }

        public var type: RegexLiteralNodeType
        public enum RegexLiteralNodeType : String, Codable { case RegexLiteral }
        public var value: Bric; // RegExp
        public var raw: String
        public var regex: Regex
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct RestElement : JSSyntaxAST {
        public init(type: RestElementNodeType = .RestElement, argument: OneOf<BindingIdentifier>.Or<BindingPattern>) {
            self.type = type
            self.argument = argument
        }

        public var type: RestElementNodeType
        public enum RestElementNodeType : String, Codable { case RestElement }
        public var argument: OneOf<BindingIdentifier>.Or<BindingPattern>
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ReturnStatement : JSSyntaxAST {
        public init(type: ReturnStatementNodeType = .ReturnStatement, argument: Nullable<Expression>) {
            self.type = type
            self.argument = argument
        }

        public var type: ReturnStatementNodeType
        public enum ReturnStatementNodeType : String, Codable { case ReturnStatement }
        public var argument: Nullable<Expression>
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct SequenceExpression : JSSyntaxAST {
        public init(type: SequenceExpressionNodeType = .SequenceExpression, expressions: [Expression]) {
            self.type = type
            self.expressions = expressions
        }

        public var type: SequenceExpressionNodeType
        public enum SequenceExpressionNodeType : String, Codable { case SequenceExpression }
        public var expressions: [Expression]
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct SpreadElement : JSSyntaxAST {
        public init(type: SpreadElementNodeType = .SpreadElement, argument: Expression) {
            self.type = type
            self.argument = argument
        }

        public var type: SpreadElementNodeType
        public enum SpreadElementNodeType : String, Codable { case SpreadElement }
        public var argument: Expression
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct StaticMemberExpression : JSSyntaxAST {
        public init(type: StaticMemberExpressionNodeType = .StaticMemberExpression, computed: Bool, object: Expression, property: Expression) {
            self.type = type
            self.computed = computed
            self.object = object
            self.property = property
        }

        public var type: StaticMemberExpressionNodeType
        public enum StaticMemberExpressionNodeType : String, Codable { case StaticMemberExpression }
        public var computed: Bool
        public var object: Expression
        public var property: Expression
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct Super : JSSyntaxAST {
        public init(type: SuperNodeType = .Super) {
            self.type = type
        }

        public var type: SuperNodeType
        public enum SuperNodeType : String, Codable { case Super }
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct SwitchCase : JSSyntaxAST {
        public init(type: SwitchCaseNodeType = .SwitchCase, test: Nullable<Expression>, consequent: [Statement]) {
            self.type = type
            self.test = test
            self.consequent = consequent
        }

        public var type: SwitchCaseNodeType
        public enum SwitchCaseNodeType : String, Codable { case SwitchCase }
        public var test: Nullable<Expression>
        public var consequent: [Statement]
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct SwitchStatement : JSSyntaxAST {
        public init(type: SwitchStatementNodeType = .SwitchStatement, discriminant: Expression, cases: [SwitchCase]) {
            self.type = type
            self.discriminant = discriminant
            self.cases = cases
        }

        public var type: SwitchStatementNodeType
        public enum SwitchStatementNodeType : String, Codable { case SwitchStatement }
        public var discriminant: Expression
        public var cases: [SwitchCase]
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct TaggedTemplateExpression : JSSyntaxAST {
        public init(type: TaggedTemplateExpressionNodeType = .TaggedTemplateExpression, tag: Expression, quasi: TemplateLiteral) {
            self.type = type
            self.tag = tag
            self.quasi = quasi
        }

        public var type: TaggedTemplateExpressionNodeType
        public enum TaggedTemplateExpressionNodeType : String, Codable { case TaggedTemplateExpression }
        public var tag: Expression
        public var quasi: TemplateLiteral
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct TemplateElementValue : Hashable, Codable {
        public var cooked: String
        public var raw: String
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct TemplateElement : JSSyntaxAST {
        public init(type: TemplateElementValueNodeType = .TemplateElement, value: TemplateElementValue, tail: Bool) {
            self.type = type
            self.value = value
            self.tail = tail
        }

        public var type: TemplateElementValueNodeType
        public enum TemplateElementValueNodeType : String, Codable { case TemplateElement }
        public var value: TemplateElementValue
        public var tail: Bool
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct TemplateLiteral : JSSyntaxAST {
        public init(type: TemplateLiteralNodeType = .TemplateLiteral, quasis: [TemplateElement], expressions: [Expression]) {
            self.type = type
            self.quasis = quasis
            self.expressions = expressions
        }

        public var type: TemplateLiteralNodeType
        public enum TemplateLiteralNodeType : String, Codable { case TemplateLiteral }
        public var quasis: [TemplateElement]
        public var expressions: [Expression]
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ThisExpression : JSSyntaxAST {
        public init(type: ThisExpressionNodeType = .ThisExpression) {
            self.type = type
        }

        public var type: ThisExpressionNodeType
        public enum ThisExpressionNodeType : String, Codable { case ThisExpression }
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct ThrowStatement : JSSyntaxAST {
        public init(type: ThrowStatementNodeType = .ThrowStatement, argument: Expression) {
            self.type = type
            self.argument = argument
        }

        public var type: ThrowStatementNodeType
        public enum ThrowStatementNodeType : String, Codable { case ThrowStatement }
        public var argument: Expression
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct TryStatement : JSSyntaxAST {
        public init(type: TryStatementNodeType = .TryStatement, block: BlockStatement, handler: Nullable<CatchClause>, finalizer: Nullable<BlockStatement>) {
            self.type = type
            self.block = block
            self.handler = handler
            self.finalizer = finalizer
        }

        public var type: TryStatementNodeType
        public enum TryStatementNodeType : String, Codable { case TryStatement }
        public var block: BlockStatement
        public var handler: Nullable<CatchClause>
        public var finalizer: Nullable<BlockStatement>
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct UnaryExpression : JSSyntaxAST {
        public init(type: UnaryExpressionNodeType = .UnaryExpression, `operator`: String, argument: Expression, prefix: Bool) {
            self.type = type
            self.`operator` = `operator`
            self.argument = argument
            self.prefix = prefix
        }

        public var type: UnaryExpressionNodeType
        public enum UnaryExpressionNodeType : String, Codable { case UnaryExpression }
        public var `operator`: String
        public var argument: Expression
        public var prefix: Bool
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct UpdateExpression : JSSyntaxAST {
        public init(type: UpdateExpressionNodeType = .UpdateExpression, `operator`: String, argument: Expression, prefix: Bool) {
            self.type = type
            self.`operator` = `operator`
            self.argument = argument
            self.prefix = prefix
        }

        public var type: UpdateExpressionNodeType
        public enum UpdateExpressionNodeType : String, Codable { case UpdateExpression }
        public var `operator`: String
        public var argument: Expression
        public var prefix: Bool
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct VariableDeclaration : JSSyntaxAST {
        public init(type: VariableDeclarationNodeType = .VariableDeclaration, declarations: [VariableDeclarator], kind: String) {
            self.type = type
            self.declarations = declarations
            self.kind = kind
        }

        public var type: VariableDeclarationNodeType
        public enum VariableDeclarationNodeType : String, Codable { case VariableDeclaration }
        public var declarations: [VariableDeclarator]
        public var kind: String
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct VariableDeclarator : JSSyntaxAST {
        public init(type: VariableDeclaratorNodeType = .VariableDeclarator, id: OneOf<BindingIdentifier>.Or<BindingPattern>, `init`: Nullable<Expression>) {
            self.type = type
            self.id = id
            self.`init` = `init`
        }

        public var type: VariableDeclaratorNodeType
        public enum VariableDeclaratorNodeType : String, Codable { case VariableDeclarator }
        public var id: OneOf<BindingIdentifier>.Or<BindingPattern>
        public var `init`: Nullable<Expression>
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct WhileStatement : JSSyntaxAST {
        public init(type: WhileStatementNodeType = .WhileStatement, test: Expression, body: Statement) {
            self.type = type
            self.test = test
            self.body = body
        }

        public var type: WhileStatementNodeType
        public enum WhileStatementNodeType : String, Codable { case WhileStatement }
        public var test: Expression
        public var body: Statement
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct WithStatement : JSSyntaxAST {
        public init(type: WithStatementNodeType = .WithStatement, object: Expression, body: Statement) {
            self.type = type
            self.object = object
            self.body = body
        }

        public var type: WithStatementNodeType
        public enum WithStatementNodeType : String, Codable { case WithStatement }
        public var object: Expression
        public var body: Statement
    }

    /// See: [Syntax Tree Format](https://esprima.readthedocs.io/en/4.0/syntax-tree-format.html)
    public struct YieldExpression : JSSyntaxAST {
        public init(type: YieldExpressionNodeType = .YieldExpression, argument: Nullable<Expression>, delegate: Bool) {
            self.type = type
            self.argument = argument
            self.delegate = delegate
        }

        public var type: YieldExpressionNodeType
        public enum YieldExpressionNodeType : String, Codable { case YieldExpression }
        public var argument: Nullable<Expression>
        public var delegate: Bool
    }
}

extension JSSyntax {
    public typealias StatementListItem = OneOf<Declaration>
        .Or<Statement>

    public typealias ModuleItem = OneOf<ImportDeclaration>
        .Or<ExportDeclaration>
        .Or<StatementListItem>

    public typealias ArgumentListElement = OneOf<Expression>
        .Or<SpreadElement>

    public typealias ArrayExpressionElement = OneOf<Expression>
        .Or<SpreadElement>
        .Or<ExplicitNull>

    public typealias ArrayPatternElement = OneOf<AssignmentPattern>
        .Or<BindingIdentifier>
        .Or<BindingPattern>
        .Or<RestElement>
        .Or<ExplicitNull>

    public typealias BindingPattern = OneOf<ArrayPattern>
        .Or<ObjectPattern>

    public typealias BindingIdentifier = Identifier

    public typealias Declaration = OneOf<AsyncFunctionDeclaration>
        .Or<ClassDeclaration>
        .Or<ExportDeclaration>
        .Or<FunctionDeclaration>
        .Or<ImportDeclaration>
        .Or<VariableDeclaration>

    public typealias ExportableDefaultDeclaration = OneOf<BindingIdentifier>
        .Or<BindingPattern>
        .Or<ClassDeclaration>
        .Or<Expression>
        .Or<FunctionDeclaration>

    public typealias ExportableNamedDeclaration = OneOf<AsyncFunctionDeclaration>
        .Or<ClassDeclaration>
        .Or<FunctionDeclaration>
        .Or<VariableDeclaration>

    public typealias ExportDeclaration = OneOf<ExportAllDeclaration>
        .Or<ExportDefaultDeclaration>
        .Or<ExportNamedDeclaration>

    public typealias Expression = OneOf<OneOf<ArrayExpression>
            .Or<ArrowFunctionExpression>
            .Or<AssignmentExpression>
            .Or<AsyncArrowFunctionExpression>
            .Or<AsyncFunctionExpression>
            .Or<AwaitExpression>
            .Or<BinaryExpression>
            .Or<CallExpression>
            .Or<ClassExpression>
            .Or<ComputedMemberExpression>>
        .Or<OneOf<ConditionalExpression>
            .Or<Identifier>
            .Or<FunctionExpression>
            .Or<Literal>
            .Or<NewExpression>
            .Or<ObjectExpression>
            .Or<RegexLiteral>
            .Or<SequenceExpression>
            .Or<StaticMemberExpression>
            .Or<TaggedTemplateExpression>>
        .Or<OneOf<ThisExpression>
            .Or<UnaryExpression>
            .Or<UpdateExpression>
            .Or<YieldExpression>>

    public typealias FunctionParameter = OneOf<AssignmentPattern>
        .Or<BindingIdentifier>
        .Or<BindingPattern>

    public typealias ImportDeclarationSpecifier = OneOf<ImportDefaultSpecifier>
        .Or<ImportNamespaceSpecifier>
        .Or<ImportSpecifier>

    public typealias ObjectExpressionProperty = OneOf<Property>
        .Or<SpreadElement>

    public typealias ObjectPatternProperty = OneOf<Property>
        .Or<RestElement>

    public typealias Statement = OneOf<OneOf<BlockStatement>
            .Or<BreakStatement>
            .Or<ContinueStatement>
            .Or<DebuggerStatement>
            .Or<DoWhileStatement>
            .Or<EmptyStatement>
            .Or<ForStatement>
            .Or<ExpressionStatement>
            .Or<Directive>
            .Or<ForInStatement>>
        .Or<OneOf<ForOfStatement>
            .Or<FunctionDeclaration>
            .Or<IfStatement>
            .Or<ReturnStatement>
            .Or<SwitchStatement>
            .Or<ThrowStatement>
            .Or<TryStatement>
            .Or<VariableDeclaration>
            .Or<WhileStatement>
            .Or<WithStatement>>

    public typealias PropertyKey = OneOf<Identifier>
        .Or<Literal>

    public typealias PropertyValue = OneOf<AssignmentPattern>
        .Or<AsyncFunctionExpression>
        .Or<BindingIdentifier>
        .Or<BindingPattern>
        .Or<FunctionExpression>
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



// - MARK: nodes.ts

public protocol JSSyntaxASTType : Codable {
    /// The name of the AST Type
    var typeName: String { get }
}

public protocol JSSyntaxAST : Hashable, JSSyntaxASTType {
    associatedtype NodeType : RawRepresentable where NodeType.RawValue == String
    var type: NodeType { get }
}

public extension JSSyntaxAST {
    var typeName: String { type.rawValue }
}

extension Never : JSSyntaxASTType {
    public var typeName: String { fatalError("never") }
}

extension OneOf2 : JSSyntaxASTType where T1: JSSyntaxASTType, T2: JSSyntaxASTType {
    public var typeName: String { expanded.typeName }
}

extension OneOf3 : JSSyntaxASTType where T1: JSSyntaxASTType, T2: JSSyntaxASTType, T3: JSSyntaxASTType {
    public var typeName: String { expanded.typeName }
}

extension OneOf4 : JSSyntaxASTType where T1: JSSyntaxASTType, T2: JSSyntaxASTType, T3: JSSyntaxASTType, T4: JSSyntaxASTType {
    public var typeName: String { expanded.typeName }
}

extension OneOf5 : JSSyntaxASTType where T1: JSSyntaxASTType, T2: JSSyntaxASTType, T3: JSSyntaxASTType, T4: JSSyntaxASTType, T5: JSSyntaxASTType {
    public var typeName: String { expanded.typeName }
}

extension OneOf6 : JSSyntaxASTType where T1: JSSyntaxASTType, T2: JSSyntaxASTType, T3: JSSyntaxASTType, T4: JSSyntaxASTType, T5: JSSyntaxASTType, T6: JSSyntaxASTType {
    public var typeName: String { expanded.typeName }
}

extension OneOf7 : JSSyntaxASTType where T1: JSSyntaxASTType, T2: JSSyntaxASTType, T3: JSSyntaxASTType, T4: JSSyntaxASTType, T5: JSSyntaxASTType, T6: JSSyntaxASTType, T7: JSSyntaxASTType {
    public var typeName: String { expanded.typeName }
}

extension OneOf8 : JSSyntaxASTType where T1: JSSyntaxASTType, T2: JSSyntaxASTType, T3: JSSyntaxASTType, T4: JSSyntaxASTType, T5: JSSyntaxASTType, T6: JSSyntaxASTType, T7: JSSyntaxASTType, T8: JSSyntaxASTType {
    public var typeName: String { expanded.typeName }
}

extension OneOf9 : JSSyntaxASTType where T1: JSSyntaxASTType, T2: JSSyntaxASTType, T3: JSSyntaxASTType, T4: JSSyntaxASTType, T5: JSSyntaxASTType, T6: JSSyntaxASTType, T7: JSSyntaxASTType, T8: JSSyntaxASTType, T9: JSSyntaxASTType {
    public var typeName: String { expanded.typeName }
}

extension OneOf10 : JSSyntaxASTType where T1: JSSyntaxASTType, T2: JSSyntaxASTType, T3: JSSyntaxASTType, T4: JSSyntaxASTType, T5: JSSyntaxASTType, T6: JSSyntaxASTType, T7: JSSyntaxASTType, T8: JSSyntaxASTType, T9: JSSyntaxASTType, T10: JSSyntaxASTType {
    public var typeName: String {
        self[routing: (\.typeName, \.typeName, \.typeName, \.typeName, \.typeName, \.typeName, \.typeName, \.typeName, \.typeName, \.typeName)]
    }
}
