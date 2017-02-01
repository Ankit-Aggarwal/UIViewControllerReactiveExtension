# UIViewControllerReactiveExtension

Usage 
`    let keyboardStatusProperty = MutableProperty<KeyboardStatusInfo?>(nil)`
`        self.keyboardStatusProperty <~ self.keyboardUpdatesSignal()`
