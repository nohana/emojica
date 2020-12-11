![emojica](https://raw.githubusercontent.com/xoudini/emojica/images/emojica.png)
=====

<sup>
Emojica – a Swift framework for using custom emoji in strings.
</sup>

![gif](https://raw.githubusercontent.com/xoudini/emojica/images/demo.gif)

## What does it do?

Emojica allows you to replace the standard emoji in your iOS apps with
[custom emoji](#compatible-image-sets).
Works on `UILabel` and `UITextView`.

Just follow the instructions below, import your custom image set, and you're
ready to go.



## Features

- [x] Compatible with __all__ iOS 13 emoji
- [x] Works with any image set<sup>1</sup>
- [x] Safe to use even with incomplete image sets<sup>2</sup>
- [x] Convert input directly on [`textViewDidChange(_:)`](#directly-converting-text-input)
- [x] Revert converted strings to their original representation

<sup>
1. The naming should follow a similar pattern as the compatible image sets.
</sup>
<br>
<sup>
2. The original emoji are used as fallback.
</sup>



## Requirements

+ Xcode 11
+ iOS 13.0+
   * _Lower versions haven't been tested, although the framework may run without
      issues on a lower version._
+ Swift 5
   * _Using the framework in an Objective-C project may require some
      modifications to the source. Support for Objective-C will possibly be
      added at some point in the future._



## Installation

### [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)

1. Add the pod to your `Podfile`:

 ```ruby
 target '...' do
     pod 'Emojica'
 end
 ```
2. Navigate into your project directory and install/update:

 ```sh
 $ cd /Path/To/Your/Project/ && pod install
 ```

### [Carthage](https://github.com/Carthage/Carthage)

1. Add this to your `Cartfile`:

```
github "xoudini/emojica"
```

2. Navigate into your project directory and install/update:

 ```sh
 $ cd /Path/To/Your/Project/ && carthage update
 ```

### Manual installation

1. Clone the repository, and drag `Emojica.xcodeproj` into your project
    hierarchy in Xcode.
2. Select your project, then select your application's target under __Targets__.
3. Under the __General__ tab, click the __+__ under __Embedded Binaries__.
4. Select `Emojica.frameworkiOS` and finish by pressing __Add__.

 > If Xcode gives you a `No such module 'Emojica'` compiler error at your
 >`import` statement, just build your application (or the framework) once. Also,
 > each time you Clean (⇧⌘K) the project Xcode will give you the same error,
 > and the solution is the same.



## Usage

```swift
import Emojica
```

### Instantiation

```swift
let emojica = Emojica()

// Creates an instance with a font.
let emojica = Emojica(font: UIFont.systemFont(ofSize: 17.0))
```

### Configure instance

* __Set font__:

   ```swift
   emojica.font = UIFont.systemFont(ofSize: 17.0)
   ```

 If no font is set, the system font is used.


* __Set size__:

   ```swift
   emojica.pointSize = 17.0
   ```

 If you're satisfied with the default font, you can just set the size.
 The value for `pointSize` is 17.0 by default.


* __Set minimum code point width__:

 > __NOTE__: Use this only when using a custom image set that
 > [isn't handled by Emojica](#compatible-image-sets).

   ```swift
   emojica.minimumCodePointWidth = 4
   ```

 A value between 0 and 8 that sets the minimum width for code point strings in
 order to correctly find the images for the custom emoji. The character `0` is
 used for padding.

 To find a suitable value, find the image for e.g. © (`U+00A9 COPYRIGHT SIGN`),
 and use the length of that image's name – `a9.png` has a width of 2, `00a9.png`
 has a width of 4, etc.


* __Set separator__:

 > __NOTE__: Use this only when using a custom image set that
 > [isn't handled by Emojica](#compatible-image-sets).

 ```swift
 emojica.separator = "~"
 ```

 The separator used in the image names of combined code points.


* __Set image set used in the project__:

   ```swift
   emojica.imageSet = .default
   ```

 Automatically configures settings specific to the image set.


* __Disable modifier symbols__:

   ```swift
   emojica.useModifiers = false
   ```

 Strips out all [modifier symbols](http://unicode.org/reports/tr51/#Emoji_Modifiers_Table)
 from complete modifier sequences.


* __Enable emoji to be reverted__:

 > __NOTE__: Keep the instance non-revertible if the original strings aren't
 > needed after conversion.

   ```swift
   emojica.revertible = true
   ```

 Enables strings with custom emoji to be reverted to original state.


### Convert string

```swift
let sample: String = "Sample text 😎"

let converted: NSAttributedString = emojica.convert(string: sample)
```

### Revert string

> __NOTE__: The instance must have `revertible` set to `true`.

```swift
let reverted: String = emojica.revert(attributedString: converted)
```

### Using converted strings

```swift
let textView = UITextView()

...

let flag: String = "🇫🇮 "

textView.attributedText = emojica.convert(string: flag)
```

### Directly converting text input

You can directly convert text input by implementing the `UITextViewDelegate`
method `textViewDidChange(_:)` and passing the changed `UITextView` to the
Emojica method by the same name:

```swift
func textViewDidChange(_ textView: UITextView) {
    emojica.textViewDidChange(textView)
}
```



## Compatible Image Sets

> The below image sets are tested, but other image sets may work just as well.
> If you have an image set that should be added to Emojica, please create an
> [__Issue__](https://github.com/xoudini/emojica/issues).

| Set           | Version   | Notes                               |
| ------------- | --------- | ----------------------------------- |
| [Twemoji]     | v13.0     | _[Prepare](#preparations)_          |
| [EmojiOne]    | 2.2.7     | _Missing code points_<sup>1</sup>   |
| [Noto Emoji]  | 1.05      | _[Prepare](#preparations)_          |

<!-- TODO: Check newest EmojiOne and Noto -->
> __NOTE__: The newest EmojiOne and Noto sets haven't been checked in a while.

[Twemoji]: https://github.com/twitter/twemoji
[EmojiOne]: https://github.com/Ranks/emojione
[Noto Emoji]: https://github.com/googlei18n/noto-emoji

<sup>
1. U+2640, U+2642 and U+2695 and sequences containing these characters are
unsupported.
</sup>



## Example Project

The example `EmojicaExample.xcodeproj` is set up but __does not contain
images__. To test the project, add your emoji images to the `Images` group and
__Run__.



## Preparations

> __WARNING__: Running the script __will__ overwrite the image names, so __do
> not run the script over a unique image set!__


Some image sets may have to be slightly modified before usage. Check the table
in [Compatible Image Sets](#compatible-image-sets) if you're using a set marked
_Prepare_, and if you are, follow these instructions:

#### 1. Copy/move the contained file `rename.sh` into the folder containing your image set.
#### 2. Open your preferred terminal.
#### 3. Navigate into the directory:
```sh
$ cd /Path/To/Your/ImageSet/
```
#### 4. Run the script:
```sh
$ sh rename.sh
```



## Contact

Feedback and questions are welcome, create an
[__Issue__](https://github.com/xoudini/emojica/issues) for bugs, problems, and
potential feature requests.

If you end up using this framework in one of your projects, feel free to let me
know, e.g. on [Twitter](https://twitter.com/xoudini).



## Contributions

The list of contributors to this project can be found
[here](https://github.com/xoudini/emojica/graphs/contributors).

If you would like to contribute, don't hesitate to open an issue or a pull
request.



## License

Emojica is released under the **Apache License 2.0**.
