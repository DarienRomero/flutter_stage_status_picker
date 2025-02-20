# StageStatusPicker

A Flutter widget that provides a dropdown for selecting statuses with customizable options.

**Show some ❤️ and star the repo to support the project**

### Resources:
- [Pub Package](https://pub.dev/packages/flutter_stage_status_picker)
- [GitHub Repository](https://github.com/DarienRomero/flutter_stage_status_picker)

![](https://github.com/DarienRomero/flutter_stage_status_picker/blob/master/.github/art/flutter_stage_status_picker.gif?raw=true)

## Installation

Add this line to your `pubspec.yaml` file in the `dependencies` section:

```yaml
dependencies:
  flutter_stage_status_picker: ^1.0.0
```

## Usage

`StageStatusPicker` behaves provides a list of options in a box and a Dropdown to change selection.

```dart
StateStatusPicker(
  width: 300,
  options: [
    StatusPickerOption(
      id: '1'
      label: 'Option 1', 
      color: Colors.red, 
      selected: false, 
    ),
  ],
  onChanged: (_) {},
),
```
**Note:** `StageStatusPicker` widget requires a minimum width of 300 pixels. This ensures that the dropdown has enough space to display the options properly. If you provide a width less than 300 pixels, an assertion error will be thrown.

### overlayHeight

The `overlayHeight` parameter allows set the dropdown height. Note that if this value changed while Dropdown is opened it will not be visible after it is closed and opened again.

```dart
StateStatusPicker(
  width: 300,
  options: [
    StatusPickerOption(
      id: '1'
      label: 'Option 1', 
      color: Colors.red, 
      selected: false, 
    ),
  ],
  onChanged: (_) {},
  overlayHeight: 250,
),
```

### onChanged

The `onChanged` callback is triggered every time a list item switch or the select all button is pressed.

### TextField

The dropdown includes a `TextField` at the top that allows you to search through the list of options. The search functionality uses the `diacritic` package to compare the search text and item labels while ignoring diacritics (accent marks). Additionally, the search uses the `startsWith` method to perform the comparison, ensuring that the search results include only those options whose labels start with the entered search text.

### Select all button

The dropdown includes a `TextButton` that allows to select all options at once. It also triggers the `onChanged` callback

## Parameters

| Parameter | Description |
|---|---|
| `key` | Controls how one widget replaces another widget in the tree. |
| `width`* | Sets the width of options box and the dropdown. |
| `options`* | Defines options that can be selected inside the dropdown. |
| `onChanged`* | Callback that triggers everytime a switch is pressed or select all button is pressed. |
| `boxPlaceholder` | The text that is shown by default in the options box when no options are selected. |
| `overlayPlaceholder` | The text that is shown by default in the dropdown when there's no searching. |
| `boxPlaceholderTextColor` | The color of the `boxPlaceholder` text. |
| `boxTextColor` | The color of list of concatenated options in the options box when there is at least one selection. |
| `boxBorderRadius` | The border radius of options box. |
| `overlayHintTextColor` | The color of hint text in the `TextField` of the dropdown. |
| `overlayHeight` | The heigth of the dropdown. |
| `overlaySelectAllText` | The text of the Select all button in the dropdown. |
| `overlaySelectAllTextColor` | The text color of the Select all button in the dropdown. |

Parameters marked with \* are required

## MIT License
```
Copyright (c) 2018 Simon Leier

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the 'Software'), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
