import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import WeakMacroPlugin
import XCTest

var testMacros: [String: Macro.Type] = [
  "weak" : WeakifyMacro.self,
]

final class MacroExamplesPluginTests: XCTestCase {
    func testWeakify() {
        let sf: SourceFileSyntax =
        #"""
        let a = #weak(self.onClick)
        """#
        let context = BasicMacroExpansionContext.init(
            sourceFiles: [sf: .init(moduleName: "MyModule", fullFilePath: "test.swift")]
        )
        let transformedSF = sf.expand(macros: testMacros, in: context)
        XCTAssertEqual(
            transformedSF.description,
            #"""
            let a = {[weak self] in if let self {self.onClick()}}
            """#
        )
    }

    func testWeakifyArgs() {
        let sf: SourceFileSyntax =
        #"""
        let a = #weak(self.onClick(button:_:))
        """#
        let context = BasicMacroExpansionContext.init(
            sourceFiles: [sf: .init(moduleName: "MyModule", fullFilePath: "test.swift")]
        )
        let transformedSF = sf.expand(macros: testMacros, in: context)
        XCTAssertEqual(
            transformedSF.description,
            #"""
            let a = {[weak self] _arg0, _arg1 in if let self {self.onClick(button: _arg0, _arg1)}}
            """#
        )
    }
}
