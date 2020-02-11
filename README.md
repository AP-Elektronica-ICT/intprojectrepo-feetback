# Feetback

This app will be used to connect to a mat that can measure your jump height.

## Flutter documentation

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Project structure

lib/<br/>
|- fonts/<br/>
|- images/<br/>
|- models/<br/>
|- screens/<br/>
|- services/<br/>
|- utils/<br/>
|- widgets/<br/>
|- main.dart<br/>
|- routes.dart<br/>

### fonts/
A folder to save all our font files in.
Different font families should be added in sub-folders.

### images/
A folder to save all our image files in.
Different categories of images can be structured using sub-folders.

### models/
A folder to save all our class models.
These should all be .dart files, one model = one file.
Inheritance can be used depending on the needs. Clean code guys, ... clean code.

### screens/
A folder to save all our screens in, a screen is the equivalent to an activity in Android Studio. Every screen is a sub-folder, this sub-folder contains another sub-folder **"widgets"**. **This folder is used to create widgets that are only used in this screen.** It is possible that these widgets derive from a global widget.

**Example:**<br/>
screens/<br/>
|- login<br/>
    |- login.dart<br/>
    |- widgets<br/>
        |- google_button.dart<br/>


### services/
A folder to save all our services in. An example of a service is one to make http calls to an API or connect to a database.

### utils/
A folder to save all our utilities in. An example of an utility is a class that converts milliseconds to seconds, showing dates in the proper format...

**The utils folder contains the business logic of our application.**

### widgets/
A folder to save all our global widgets in.

### main.dart
This is the main entry file of our application, containing global properties like theming and stuf...

### routes.dart
This file contains a ```final Map<String, WidgetBuilder> routes```.
In this map all the routes of the application are saved.

## Naming conventions
To keep out project as clean as possible we all should use the same naming conventions for files and folders as described below.

### File naming
Files should be named without using capital letters, different word should be connected using an underscore "_".

### Folder naming
Folders should be named according to the camelCase standard.

### Class naming
Classes should be named according to the PascalCase standard.

### Variable/Property naming
Variables or porperties should be named depending in there accessibility.

#### Private
In Dart private variables always start with an '_'. As a convention we'll use a lowercase first letter.
```int _testNumber```

#### Public
These variables use camelCase.
```int testNumber```

#### Static
Should be all caps with a private static starting with a '_'.
```int TESTNUMBER``` or ```int _TESTNUMBER```

## Import structure
When importing classes at the top of our files we will make sure to separate the following using 1 empty line.

1. Flutter specific imports
2. 3th party package imports
3. Utils imports
4. Services imports
5. Models imports
6. Screen imports
7. Widget imports

## Mandatory plugins for VS Code.

1. [Dart plugin](https://marketplace.visualstudio.com/items?itemName=Dart-Code.dart-code)
2. [Flutter plugin](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter)

## Handy plugins for VS Code.

1. [Bracket Pair Colorizer 2](https://marketplace.visualstudio.com/items?itemName=CoenraadS.bracket-pair-colorizer-2)
2. [Material Icon Theme](https://marketplace.visualstudio.com/items?itemName=PKief.material-icon-theme)
3. [Flutter internationalize*](https://marketplace.visualstudio.com/items?itemName=apin.flutter-internationalize)

*Research needed.