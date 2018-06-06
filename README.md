# Short
Easly add Siri Shortcuts in your App. 

## Prerequisites
- iOS 12
- Xcode 10

## Installation

### Cocoapods
To install Short using [Cocoapods](http://cocoapods.org), add the following line to your Podfile:

```
pod 'TheAbstractDev/Short'
```

### Carthage
To install Short using [Carthage](https://github.com/Carthage/Carthage), add the following line to your Cartfile:

```
github "TheAbstractDev/Short"
```

## Usage

`import Short`

### Creating Custom Intents.

Before using Short, you'll have to create a new `SiriKit Intent Definition File`.
Once the file is created, click on the + sign and select `New Intent` and add the associated properties.

Your intent must be associated with a Class !

### Getting Registered Shortcuts
#### Getting All Shortcuts
```swift
Short.getAllVoiceShortcuts { shortcuts in
	for shortcut in shortcuts {
		print(shortcut.invocationPhrase) // prints "Swift"
	}
}
```

#### Getting a shortcut from an intent
```swift
let customIntent = Custom.intent
Short.getVoiceShortcutFrom(intent: customIntent) 
```

### Donate Intent Interations.
Before Siri can suggest shortcuts to the user, the app must tell Siri about the shortcuts through intent donations. An app makes a donation each time the user performs an action in the app.

```swift
let customIntent = Custom.intent
Short.donateInteraction(for: customIntent)
```

### Handle Shortcuts.
```swift
    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        if let intent = userActivity.interaction?.intent as? CustomIntent {
            Short.handle(intent)
            return true
        } else if userActivity.activityType == NSUserActivity.viewMenuActivityType {
            Short.handleUserActivity()
            return true
        }
        return false
    }
```

### Using Custom Responses.
The custom responses defined into your Intent File can be accesed using the ShortIntentResponse method.
```swift
print(ShortIntentResponse.customFailureResponse)
```


### Adding Phrases to Siri.
``` swift
let shortcut = Short.getShortcutFrom(intent: customIntent)
Short.presentSiriShortcutViewController(shortcut: shortcut)
```

If a phrase already exists for the shortcut, the user can also change the phrase directly from your app.

```swift
let existingShortcutVC = Short.EditSiriShortcutViewController(shortcut: shortcut)
Short.presentExistingSiriShortcutViewController(existingShortcut: shortcut)
```
