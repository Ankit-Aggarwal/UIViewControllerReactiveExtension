# UIViewControllerReactiveExtension

Usage :
This signal can be used in any controller with just two lines of code.


`    let keyboardStatusProperty = MutableProperty<KeyboardStatusInfo?>(nil)`
`        self.keyboardStatusProperty <~ self.keyboardUpdatesSignal()`
