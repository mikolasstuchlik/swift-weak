import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftDiagnostics

enum WeakifyMacroDiagnostic: String, DiagnosticMessage {
    case notAnAccessExpr
    case memberAccessNotSelf

    var severity: SwiftDiagnostics.DiagnosticSeverity { .error }
    var message: String {
        switch self {
        case .memberAccessNotSelf:
            return "#weak can only be applied to expressions on `self`"
        case .notAnAccessExpr:
            return "#weak requires member access expression as an argument"
        }
    }
    var diagnosticID: SwiftDiagnostics.MessageID { MessageID(domain: "WeakifyMacro", id: rawValue) }
}

public struct WeakifyMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) -> ExprSyntax {
        guard let argument = node.argumentList.first?.expression.as(MemberAccessExprSyntax.self) else {
            context.diagnose(.init(node: node._syntaxNode, message: WeakifyMacroDiagnostic.notAnAccessExpr))
            return ""
        }

        guard argument.base?.as(IdentifierExprSyntax.self)?.identifier.tokenKind == .keyword(.`self`) else {
            context.diagnose(.init(node: node._syntaxNode, message: WeakifyMacroDiagnostic.memberAccessNotSelf))
            return ""
        }
        let name = argument.name.text
        let args = argument.declNameArguments?.arguments.map(\.name.text) ?? []
        let argumentList = args.enumerated().map { "_arg\($0.offset)" }.joined(separator: ", ") + (args.isEmpty ? "" : " ")
        let invocationArgumentList = args.enumerated().map { item in
            var accumulator = ""
            if item.element != "_" {
                accumulator += item.element + ": "
            }
            accumulator += "_arg\(item.offset)"
            return accumulator
        }.joined(separator: ", ")

        return "{[weak self] \(raw: argumentList)in if let self {self.\(raw: name)(\(raw: invocationArgumentList))}}"
    }
}
