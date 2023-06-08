import WeakMacro

class A {
    private(set) var handler: ((Int, Bool) -> Void)?

    init() {}

    func handler(_ arg0: Int, arg1: Bool) {
        print("handled \(arg0) and \(arg1)")
    }

    func accept(handler: @escaping (Int, Bool) -> Void) {
        self.handler = handler
    }

    func foo() {
        accept(handler: #weak(self.handler(_:arg1:)))
    }

    deinit { print("deinit") }
}

var a: A? = A()
a?.foo()
a?.handler?(1, true)
a = nil
print("end")
