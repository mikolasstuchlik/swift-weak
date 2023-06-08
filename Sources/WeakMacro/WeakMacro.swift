

//@freestanding(expression) public macro weak<each A, R>(_ function: (repeat each A) -> R) -> (repeat each A) -> R = #externalMacro(module: "WeakMacroPlugin", type: "WeakifyMacro")

@freestanding(expression) public macro weak<each A, R>(_ function: (repeat each A) -> R) -> (repeat each A) -> R = #externalMacro(module: "WeakMacroPlugin", type: "WeakifyMacro")
