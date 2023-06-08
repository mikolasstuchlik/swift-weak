#if canImport(SwiftCompilerPlugin)
import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct WeakMacroPlugin: CompilerPlugin {
  let providingMacros: [Macro.Type] = [
    WeakifyMacro.self
  ]
}
#endif
