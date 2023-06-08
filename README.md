# Swift Macro for Weakify

Usage:

Use `#weak` with a member access expression on `self`:
```swift
let a = #weak(self.onClick(button:_:))
```

expands into:

```swift
let a = {[weak self] _arg0, _arg1 in if let self {self.onClick(button: _arg0, _arg1)}}
```

There is an example module `WeakMacroExample`

*Also, yes. I know, I should have used `context.makeUniqueName()` :) *
