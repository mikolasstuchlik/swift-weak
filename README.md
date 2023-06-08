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

**Sadly it does not work, because the parameter pack trigger a compiler segault 😭**
