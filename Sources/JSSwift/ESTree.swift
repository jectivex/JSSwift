

public extension JavaScriptParser {
    /// Parses a JavaScript script.
    ///
    /// More info: [Syntactic Analysis](https://esprima.readthedocs.io/en/4.0/syntactic-analysis.html)
    func parseESTree(script javaScript: String, options: ParseOptions = .init()) throws -> ESTree.Program {
        return try ctx.trying { // invoke the cached function with the encoded arguments
            parseScriptFunction.call(withArguments: [ctx.string(javaScript), try ctx.encode(options)])
        }.toDecodable(ofType: ESTree.Program.self)
    }

    /// Parses a JavaScript module.
    ///
    /// This differs from `parse(script:)` in that it permits module syntax like imports.
    ///
    /// More info: [Syntactic Analysis](https://esprima.readthedocs.io/en/4.0/syntactic-analysis.html)
    func parseESTree(module javaScript: String, options: ParseOptions = .init()) throws -> ESTree.Program {
        return try ctx.trying { // invoke the cached function with the encoded arguments
            parseModuleFunction.call(withArguments: [ctx.string(javaScript), try ctx.encode(options)])
        }.toDecodable(ofType: ESTree.Program.self)
    }
}




/// A JavaScript AST as standardized by [ESTree](https://github.com/estree/estree/blob/master/es5.md)
///
/// Namespace for nodes corresponding to `Syntax` cases.
///
/// The syntax tree format is derived from the original version of [Mozilla Parser API](https://developer.mozilla.org/en-US/docs/Mozilla/Projects/SpiderMonkey/Parser_API), which is then formalized and expanded as the [ESTree specification](https://github.com/estree/estree).
public enum ESTree {

    /// Identifier
    ///
    /// ```
    /// interface Identifier <: Expression, Pattern {
    ///     type: "Identifier";
    ///     name: string;
    /// }
    /// ```
    ///
    /// An identifier. Note that an identifier may be an expression or a destructuring pattern.
    public struct Identifier : JSSyntaxNode {
        public let type: IdentifierNodeType
        public enum IdentifierNodeType : String, Codable { case Identifier }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// Literal
    ///
    ///    interface Literal <: Expression {
    ///        type: "Literal";
    ///        value: string | boolean | null | number | RegExp;
    ///    }
    ///    A literal token. Note that a literal can be an expression.
    public struct Literal : JSSyntaxNode {
        public let type: LiteralNodeType
        public enum LiteralNodeType : String, Codable { case Literal }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    ///    RegExpLiteral
    ///
    ///    interface RegExpLiteral <: Literal {
    ///      regex: {
    ///        pattern: string;
    ///        flags: string;
    ///      };
    ///    }
    ///    The regex property allows regexes to be represented in environments that don’t support certain flags such as y or u. In environments that don't support these flags value will be null as the regex can't be represented natively.
    public struct RegExpLiteral : JSSyntaxNode {
        public let type: RegExpLiteralNodeType
        public enum RegExpLiteralNodeType : String, Codable { case RegExpLiteral }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    ///    Programs
    ///
    ///    interface Program <: Node {
    ///        type: "Program";
    ///        body: [ Directive | Statement ];
    ///    }
    ///    A complete program source tree.
    public struct Program : JSSyntaxNode {
        public let type: ProgramNodeType
        public enum ProgramNodeType : String, Codable { case Program }

        public var body: [OneOf<Declaration>.Or<Statement>]

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// MARK: Functions


    ///    interface Function <: Node {
    ///        id: Identifier | null;
    ///        params: [ Pattern ];
    ///        body: FunctionBody;
    ///    }
    ///    A function declaration or expression.
    public typealias Function = OneOf<FunctionDeclaration>
        .Or<FunctionExpression>


    // MARK: Statements

    /// Statements
    ///
    ///    interface Statement <: Node { }
    ///    Any statement.
    public typealias Statement = OneOf<ExpressionStatement>
        .Or<Directive>
        .Or<BlockStatement>
        .Or<EmptyStatement>
        .Or<DebuggerStatement>
        .Or<WithStatement>
        .Or<ReturnStatement>
        .Or<LabeledStatement>
        .Or<BreakStatement>
        .Or<ContinueStatement>
        .Or<IfStatement>
        .Or<SwitchStatement>
        .Or<ThrowStatement>
        .Or<TryStatement>
        .Or<WhileStatement>
        .Or<DoWhileStatement>
        .Or<ForStatement>
        .Or<ForInStatement>
        .Or<Declaration>

    ///    ExpressionStatement
    ///
    ///    interface ExpressionStatement <: Statement {
    ///        type: "ExpressionStatement";
    ///        expression: Expression;
    ///    }
    ///    An expression statement, i.e., a statement consisting of a single expression.
    public struct ExpressionStatement : JSSyntaxNode {
        public let type: ExpressionStatementNodeType
        public enum ExpressionStatementNodeType : String, Codable { case ExpressionStatement }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    ///    Directive
    ///
    ///    interface Directive <: Node {
    ///        type: "ExpressionStatement";
    ///        expression: Literal;
    ///        directive: string;
    ///    }
    ///    A directive from the directive prologue of a script or function. The directive property is the raw string source of the directive without quotes.
    public struct Directive : JSSyntaxNode {
        public let type: DirectiveNodeType
        public enum DirectiveNodeType : String, Codable { case Directive }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }


    ///    BlockStatement
    ///
    ///    interface BlockStatement <: Statement {
    ///        type: "BlockStatement";
    ///        body: [ Statement ];
    ///    }
    ///    A block statement, i.e., a sequence of statements surrounded by braces.
    public struct BlockStatement : JSSyntaxNode {
        public let type: BlockStatementNodeType
        public enum BlockStatementNodeType : String, Codable { case BlockStatement }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    ///    FunctionBody
    ///
    ///    interface FunctionBody <: BlockStatement {
    ///        body: [ Directive | Statement ];
    ///    }
    ///    The body of a function, which is a block statement that may begin with directives.
    public typealias FunctionBody = BlockStatement // difference is that BlockStatement's body is just [Statement]

    ///    EmptyStatement
    ///
    ///    interface EmptyStatement <: Statement {
    ///        type: "EmptyStatement";
    ///    }
    ///    An empty statement, i.e., a solitary semicolon.
    public struct EmptyStatement : JSSyntaxNode {
        public let type: EmptyStatementNodeType
        public enum EmptyStatementNodeType : String, Codable { case EmptyStatement }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    ///    DebuggerStatement
    ///
    ///    interface DebuggerStatement <: Statement {
    ///        type: "DebuggerStatement";
    ///    }
    ///    A debugger statement.
    public struct DebuggerStatement : JSSyntaxNode {
        public let type: DebuggerStatementNodeType
        public enum DebuggerStatementNodeType : String, Codable { case DebuggerStatement }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    ///    WithStatement
    ///
    ///    interface WithStatement <: Statement {
    ///        type: "WithStatement";
    ///        object: Expression;
    ///        body: Statement;
    ///    }
    ///    A with statement.
    public struct WithStatement : JSSyntaxNode {
        public let type: WithStatementNodeType
        public enum WithStatementNodeType : String, Codable { case WithStatement }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    // MARK: Control flow


    ///    ReturnStatement
    ///
    ///    interface ReturnStatement <: Statement {
    ///        type: "ReturnStatement";
    ///        argument: Expression | null;
    ///    }
    ///    A return statement.
    public struct ReturnStatement : JSSyntaxNode {
        public let type: ReturnStatementNodeType
        public enum ReturnStatementNodeType : String, Codable { case ReturnStatement }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    ///    LabeledStatement
    ///
    ///    interface LabeledStatement <: Statement {
    ///        type: "LabeledStatement";
    ///        label: Identifier;
    ///        body: Statement;
    ///    }
    ///    A labeled statement, i.e., a statement prefixed by a break/continue label.
    public struct LabeledStatement : JSSyntaxNode {
        public let type: LabeledStatementNodeType
        public enum LabeledStatementNodeType : String, Codable { case LabeledStatement }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    ///    BreakStatement
    ///
    ///    interface BreakStatement <: Statement {
    ///        type: "BreakStatement";
    ///        label: Identifier | null;
    ///    }
    ///    A break statement.
    public struct BreakStatement : JSSyntaxNode {
        public let type: BreakStatementNodeType
        public enum BreakStatementNodeType : String, Codable { case BreakStatement }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    ///    ContinueStatement
    ///
    ///    interface ContinueStatement <: Statement {
    ///        type: "ContinueStatement";
    ///        label: Identifier | null;
    ///    }
    ///    A continue statement.
    public struct ContinueStatement : JSSyntaxNode {
        public let type: ContinueStatementNodeType
        public enum ContinueStatementNodeType : String, Codable { case ContinueStatement }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// MARK: Choice


    ///    IfStatement
    ///
    ///    interface IfStatement <: Statement {
    ///        type: "IfStatement";
    ///        test: Expression;
    ///        consequent: Statement;
    ///        alternate: Statement | null;
    ///    }
    ///    An if statement.
    public struct IfStatement : JSSyntaxNode {
        public let type: IfStatementNodeType
        public enum IfStatementNodeType : String, Codable { case IfStatement }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    ///    SwitchStatement
    ///
    ///    interface SwitchStatement <: Statement {
    ///        type: "SwitchStatement";
    ///        discriminant: Expression;
    ///        cases: [ SwitchCase ];
    ///    }
    ///    A switch statement.
    public struct SwitchStatement : JSSyntaxNode {
        public let type: SwitchStatementNodeType
        public enum SwitchStatementNodeType : String, Codable { case SwitchStatement }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    ///    SwitchCase
    ///
    ///    interface SwitchCase <: Node {
    ///        type: "SwitchCase";
    ///        test: Expression | null;
    ///        consequent: [ Statement ];
    ///    }
    ///    A case (if test is an Expression) or default (if test === null) clause in the body of a switch statement.
    public struct SwitchCase : JSSyntaxNode {
        public let type: SwitchCaseNodeType
        public enum SwitchCaseNodeType : String, Codable { case SwitchCase }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// MARK: Exceptions


    ///    ThrowStatement
    ///
    ///    interface ThrowStatement <: Statement {
    ///        type: "ThrowStatement";
    ///        argument: Expression;
    ///    }
    ///    A throw statement.
    public struct ThrowStatement : JSSyntaxNode {
        public let type: ThrowStatementNodeType
        public enum ThrowStatementNodeType : String, Codable { case ThrowStatement }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    ///    TryStatement
    ///
    ///    interface TryStatement <: Statement {
    ///        type: "TryStatement";
    ///        block: BlockStatement;
    ///        handler: CatchClause | null;
    ///        finalizer: BlockStatement | null;
    ///    }
    ///    A try statement. If handler is null then finalizer must be a BlockStatement.
    public struct TryStatement : JSSyntaxNode {
        public let type: TryStatementNodeType
        public enum TryStatementNodeType : String, Codable { case TryStatement }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    ///    CatchClause
    ///
    ///    interface CatchClause <: Node {
    ///        type: "CatchClause";
    ///        param: Pattern;
    ///        body: BlockStatement;
    ///    }
    ///    A catch clause following a try block.
    public struct CatchClause : JSSyntaxNode {
        public let type: CatchClauseNodeType
        public enum CatchClauseNodeType : String, Codable { case CatchClause }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// MARK: Loops


    ///    WhileStatement
    ///
    ///    interface WhileStatement <: Statement {
    ///        type: "WhileStatement";
    ///        test: Expression;
    ///        body: Statement;
    ///    }
    ///    A while statement.
    public struct WhileStatement : JSSyntaxNode {
        public let type: WhileStatementNodeType
        public enum WhileStatementNodeType : String, Codable { case WhileStatement }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    ///    DoWhileStatement
    ///
    ///    interface DoWhileStatement <: Statement {
    ///        type: "DoWhileStatement";
    ///        body: Statement;
    ///        test: Expression;
    ///    }
    ///    A do/while statement.
    public struct DoWhileStatement : JSSyntaxNode {
        public let type: DoWhileStatementNodeType
        public enum DoWhileStatementNodeType : String, Codable { case DoWhileStatement }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    ///    ForStatement
    ///
    ///    interface ForStatement <: Statement {
    ///        type: "ForStatement";
    ///        init: VariableDeclaration | Expression | null;
    ///        test: Expression | null;
    ///        update: Expression | null;
    ///        body: Statement;
    ///    }
    ///    A for statement.
    public struct ForStatement : JSSyntaxNode {
        public let type: ForStatementNodeType
        public enum ForStatementNodeType : String, Codable { case ForStatement }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    ///    ForInStatement
    ///
    ///    interface ForInStatement <: Statement {
    ///        type: "ForInStatement";
    ///        left: VariableDeclaration |  Pattern;
    ///        right: Expression;
    ///        body: Statement;
    ///    }
    ///    A for/in statement.
    public struct ForInStatement : JSSyntaxNode {
        public let type: ForInStatementNodeType
        public enum ForInStatementNodeType : String, Codable { case ForInStatement }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    /// MARK: Declarations

    ///    interface Declaration <: Statement { }
    ///    Any declaration node. Note that declarations are considered statements; this is because declarations can appear in any statement context.
    public typealias Declaration = OneOf<FunctionDeclaration>.Or<VariableDeclaration>

    ///    FunctionDeclaration
    ///
    ///    interface FunctionDeclaration <: Function, Declaration {
    ///        type: "FunctionDeclaration";
    ///        id: Identifier;
    ///    }
    ///    A function declaration. Note that unlike in the parent interface Function, the id cannot be null.
    public struct FunctionDeclaration : JSSyntaxNode {
        public let type: FunctionDeclarationNodeType
        public enum FunctionDeclarationNodeType : String, Codable { case FunctionDeclaration }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    ///    VariableDeclaration
    ///
    ///    interface VariableDeclaration <: Declaration {
    ///        type: "VariableDeclaration";
    ///        declarations: [ VariableDeclarator ];
    ///        kind: "var";
    ///    }
    ///    A variable declaration.
    public struct VariableDeclaration : JSSyntaxNode {
        public let type: VariableDeclarationNodeType
        public enum VariableDeclarationNodeType : String, Codable { case VariableDeclaration }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    ///    VariableDeclarator
    ///
    ///    interface VariableDeclarator <: Node {
    ///        type: "VariableDeclarator";
    ///        id: Pattern;
    ///        init: Expression | null;
    ///    }
    ///    A variable declarator.
    public struct VariableDeclarator : JSSyntaxNode {
        public let type: VariableDeclaratorNodeType
        public enum VariableDeclaratorNodeType : String, Codable { case VariableDeclarator }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    // MARK: Expressions

    ///    interface Expression <: Node { }
    ///    Any expression node. Since the left-hand side of an assignment may be any expression in general, an expression can also be a pattern.
    public typealias Expression = OneOf<Identifier>
        .Or<Literal>
        .Or<RegExpLiteral>
        .Or<ThisExpression>
        .Or<ArrayExpression>
        .Or<ObjectExpression>
        .Or<UnaryExpression>
        .Or<UpdateExpression>
        .Or<BinaryExpression>
        .Or<AssignmentExpression>
        .Or<LogicalExpression>
        .Or<MemberExpression>
        .Or<ConditionalExpression>
        .Or<CallExpression>
        .Or<NewExpression>
        .Or<SequenceExpression>

    ///    ThisExpression
    ///
    ///    interface ThisExpression <: Expression {
    ///        type: "ThisExpression";
    ///    }
    ///    A this expression.
    public struct ThisExpression : JSSyntaxNode {
        public let type: ThisExpressionNodeType
        public enum ThisExpressionNodeType : String, Codable { case ThisExpression }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    ///    ArrayExpression
    ///
    ///    interface ArrayExpression <: Expression {
    ///        type: "ArrayExpression";
    ///        elements: [ Expression | null ];
    ///    }
    ///    An array expression. An element might be null if it represents a hole in a sparse array. E.g. [1,,2].
    public struct ArrayExpression : JSSyntaxNode {
        public let type: ArrayExpressionNodeType
        public enum ArrayExpressionNodeType : String, Codable { case ArrayExpression }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    ///    ObjectExpression
    ///
    ///    interface ObjectExpression <: Expression {
    ///        type: "ObjectExpression";
    ///        properties: [ Property ];
    ///    }
    ///    An object expression.
    public struct ObjectExpression : JSSyntaxNode {
        public let type: ObjectExpressionNodeType
        public enum ObjectExpressionNodeType : String, Codable { case ObjectExpression }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    ///    Property
    ///
    ///    interface Property <: Node {
    ///        type: "Property";
    ///        key: Literal | Identifier;
    ///        value: Expression;
    ///        kind: "init" | "get" | "set";
    ///    }
    ///    A literal property in an object expression can have either a string or number as its value. Ordinary property initializers have a kind value "init"; getters and setters have the kind values "get" and "set", respectively.
    public struct Property : JSSyntaxNode {
        public let type: PropertyNodeType
        public enum PropertyNodeType : String, Codable { case Property }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    ///    FunctionExpression
    ///
    ///    interface FunctionExpression <: Function, Expression {
    ///        type: "FunctionExpression";
    ///    }
    ///    A function expression.
    public struct FunctionExpression : JSSyntaxNode {
        public let type: FunctionExpressionNodeType
        public enum FunctionExpressionNodeType : String, Codable { case FunctionExpression }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    // MARK: Unary operations

    ///    UnaryExpression
    ///
    ///    interface UnaryExpression <: Expression {
    ///        type: "UnaryExpression";
    ///        operator: UnaryOperator;
    ///        prefix: boolean;
    ///        argument: Expression;
    ///    }
    ///    A unary operator expression.
    public struct UnaryExpression : JSSyntaxNode {
        ///    UnaryOperator
        ///
        ///    enum UnaryOperator {
        ///        "-" | "+" | "!" | "~" | "typeof" | "void" | "delete"
        ///    }
        ///    A unary operator token.
        public let type: UnaryExpressionNodeType
        public enum UnaryExpressionNodeType : String, Codable { case UnaryExpression }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    ///    UpdateExpression
    ///
    ///    interface UpdateExpression <: Expression {
    ///        type: "UpdateExpression";
    ///        operator: UpdateOperator;
    ///        argument: Expression;
    ///        prefix: boolean;
    ///    }
    ///    An update (increment or decrement) operator expression.
    public struct UpdateExpression : JSSyntaxNode {
        ///    UpdateOperator
        ///
        ///    enum UpdateOperator {
        ///        "++" | "--"
        ///    }
        ///    An update (increment or decrement) operator token.
        public let type: UpdateExpressionNodeType
        public enum UpdateExpressionNodeType : String, Codable { case UpdateExpression }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }


    // MARK: Binary operations

    ///    BinaryExpression
    ///
    ///    interface BinaryExpression <: Expression {
    ///        type: "BinaryExpression";
    ///        operator: BinaryOperator;
    ///        left: Expression;
    ///        right: Expression;
    ///    }
    ///    A binary operator expression.
    public struct BinaryExpression : JSSyntaxNode {
        ///    BinaryOperator
        ///
        ///    enum BinaryOperator {
        ///        "==" | "!=" | "===" | "!=="
        ///             | "<" | "<=" | ">" | ">="
        ///             | "<<" | ">>" | ">>>"
        ///             | "+" | "-" | "*" | "/" | "%"
        ///             | "|" | "^" | "&" | "in"
        ///             | "instanceof"
        ///    }
        ///    A binary operator token.
        public let type: BinaryExpressionNodeType
        public enum BinaryExpressionNodeType : String, Codable { case BinaryExpression }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }


    ///    AssignmentExpression
    ///
    ///    interface AssignmentExpression <: Expression {
    ///        type: "AssignmentExpression";
    ///        operator: AssignmentOperator;
    ///        left: Pattern | Expression;
    ///        right: Expression;
    ///    }
    ///    An assignment operator expression.
    public struct AssignmentExpression : JSSyntaxNode {
        ///    AssignmentOperator
        ///
        ///    enum AssignmentOperator {
        ///        "=" | "+=" | "-=" | "*=" | "/=" | "%="
        ///            | "<<=" | ">>=" | ">>>="
        ///            | "|=" | "^=" | "&="
        ///    }
        ///    An assignment operator token.
        public let type: AssignmentExpressionNodeType
        public enum AssignmentExpressionNodeType : String, Codable { case AssignmentExpression }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }


    ///    LogicalExpression
    ///
    ///    interface LogicalExpression <: Expression {
    ///        type: "LogicalExpression";
    ///        operator: LogicalOperator;
    ///        left: Expression;
    ///        right: Expression;
    ///    }
    ///    A logical operator expression.
    public struct LogicalExpression : JSSyntaxNode {
        ///    LogicalOperator
        ///
        ///    enum LogicalOperator {
        ///        "||" | "&&"
        ///    }
        ///    A logical operator token.
        public let type: LogicalExpressionNodeType
        public enum LogicalExpressionNodeType : String, Codable { case LogicalExpression }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }


    ///    MemberExpression
    ///
    ///    interface MemberExpression <: Expression, Pattern {
    ///        type: "MemberExpression";
    ///        object: Expression;
    ///        property: Expression;
    ///        computed: boolean;
    ///    }
    ///    A member expression. If computed is true, the node corresponds to a computed (a[b]) member expression and property is an Expression. If computed is false, the node corresponds to a static (a.b) member expression and property is an Identifier.
    public struct MemberExpression : JSSyntaxNode {
        public let type: MemberExpressionNodeType
        public enum MemberExpressionNodeType : String, Codable { case MemberExpression }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }

    ///    ConditionalExpression
    ///
    ///    interface ConditionalExpression <: Expression {
    ///        type: "ConditionalExpression";
    ///        test: Expression;
    ///        alternate: Expression;
    ///        consequent: Expression;
    ///    }
    ///    A conditional expression, i.e., a ternary ?/: expression.
    public struct ConditionalExpression : JSSyntaxNode {
        public let type: ConditionalExpressionNodeType
        public enum ConditionalExpressionNodeType : String, Codable { case ConditionalExpression }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }


    ///    CallExpression
    ///
    ///    interface CallExpression <: Expression {
    ///        type: "CallExpression";
    ///        callee: Expression;
    ///        arguments: [ Expression ];
    ///    }
    ///    A function or method call expression.
    public struct CallExpression : JSSyntaxNode {
        public let type: CallExpressionNodeType
        public enum CallExpressionNodeType : String, Codable { case CallExpression }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }


    ///    NewExpression
    ///
    ///    interface NewExpression <: Expression {
    ///        type: "NewExpression";
    ///        callee: Expression;
    ///        arguments: [ Expression ];
    ///    }
    ///    A new expression.
    public struct NewExpression : JSSyntaxNode {
        public let type: NewExpressionNodeType
        public enum NewExpressionNodeType : String, Codable { case NewExpression }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }


    ///    SequenceExpression
    ///
    ///    interface SequenceExpression <: Expression {
    ///        type: "SequenceExpression";
    ///        expressions: [ Expression ];
    ///    }
    ///    A sequence expression, i.e., a comma-separated sequence of expressions.
    public struct SequenceExpression : JSSyntaxNode {
        public let type: SequenceExpressionNodeType
        public enum SequenceExpressionNodeType : String, Codable { case SequenceExpression }

        public var loc: SourceLocation? = nil
        public var range: [Int]? = nil
    }


    ///    Patterns
    ///
    ///    Destructuring binding and assignment are not part of ES5, but all binding positions accept Pattern to allow for destructuring in ES6. Nevertheless, for ES5, the only Pattern subtype is Identifier.
    ///    interface Pattern <: Node { }
    public typealias Pattern = OneOf<Identifier>
        .Or<MemberExpression>

}
