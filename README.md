# UIViewControllerReactiveExtension


## A lot of time we need to observe keyboard show/hide notification to adjust our view depending on keyboard visible area.
e.g. On chat screen, text input view is made sticky to keyboard which needs to be moved with the keyboard movement.

I generated an extension helper so that keyboard updates can be easily handled on any controller with just one line of code.
This code snippet uses swift3 and ReactiveSwift to give us a signal which can be observe for the keyboard update info.

After adding extension file, updates can be handled as follows


# Usage :

 Define a mutable Property

`let keyboardStatusProperty = MutableProperty<KeyboardStatusInfo?>(nil)`

Link property to generated signal

`self.keyboardStatusProperty <~ self.keyboardUpdatesSignal()`

Start observing mutable property changes using a signal producer.

```
  self.keyboardStatusProperty.producer.skipNil().startWithValues {  keyboardUpdateInfo in
  // update constraint using keyboard visible height
            self.messageViewBottomConstraint.constant = keyboardUpdateInfo.height
            UIView.animate(withDuration: keyboardUpdateInfo.duration,
                           delay: 0,
                           options: keyboardUpdateInfo.animationOptions,
                           animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
```

