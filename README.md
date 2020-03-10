# Feetback

This app will be used to connect to a mat that can measure your jump height.

## Index
[Flutter documentation](#flutter-documentation) <br/>
[Project structure](#project-structure) <br/>
[-> fonts/](#fonts) <br/>
[-> images/](#images) <br/>
[-> models/](#models) <br/>
[-> screens/](#screens) <br/>
[-> services/](#services) <br/>
[-> utils/](#utils) <br/>
[-> widgets/](#widgets) <br/>
[-> main.dart](#maindart) <br/>
[-> routes.dart](#routesdart) <br/>
[Naming conventions](#naming-conventions) <br/>
[-> File naming](#file-naming) <br/>
[-> Folder naming](#folder-naming) <br/>
[-> Class naming](#class-naming) <br/>
[-> Variable/Property naming](#variableproperty-naming) <br/>
[--> Private](#private) <br/>
[--> Public](#public) <br/>
[--> Static](#static) <br/>
[Spacing/sizing convetions](#spacingsizing-convetions) <br/>
[Import structure](#import-structure) <br/>
[Pub packages we use](#pub-packages-we-use) <br/>
[Mandatory plugins for VS code](#mandatory-plugins-for-vs-code) <br/>
[Handy plugins for VS code](#handy-plugins-for-vs-code) <br/>
[Database](#database) <br/>

## Flutter documentation

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Project structure

>lib/<br/>
>>|- fonts/<br/>
>>|- images/<br/>
>>|- models/<br/>
>>|- screens/<br/>
>>|- services/<br/>
>>|- utils/<br/>
>>|- widgets/<br/>
>>|- main.dart<br/>
>>|- routes.dart<br/>

### fonts/
A folder to save all our font files in.
Different font families should be added in sub-folders.<br/>
[More information about font assets and how to use them.](https://flutter.dev/docs/cookbook/design/fonts)

### images/
A folder to save all our image files in.
Different categories of images can be structured using sub-folders.<br/>
[More information about image assets and how to use them.](https://flutter.dev/docs/development/ui/assets-and-images)

### models/
A folder to save all our class models.
These should all be .dart files, one model = one file.
Inheritance can be used depending on the needs. Clean code guys, ... clean code.<br/>
[Serializing JSON using code generation libraries](https://flutter.dev/docs/development/data-and-backend/json#serializing-json-using-code-generation-libraries)

### screens/
A folder to save all our screens in, a screen is the equivalent to an activity in Android Studio. Every screen is a sub-folder, this sub-folder contains another sub-folder **"widgets"**. **This folder is used to create widgets that are only used in this screen.** It is possible that these widgets derive from a global widget.

**Example:**<br/>
>screens/<br/>
>>|- login<br/>
>>>|- login.dart<br/>
>>>|- widgets/<br/>
>>>>|- google_button.dart<br/>

Another important aspect of a screen is that the **root widget** of a screen should always be a ```Scaffold``` widget which provides basic functionalities like snackbar notifications, ...<br/>
[More information about the Scaffold widget.](https://api.flutter.dev/flutter/material/Scaffold-class.html)<br/>
[Tutorial about the Scaffold widget.](https://www.youtube.com/watch?v=C5lpPjoivaw)


### services/
A folder to save all our services in. An example of a service is one to make http calls to an API or connect to a database.

### utils/
A folder to save all our utilities in. An example of an utility is a class that converts milliseconds to seconds, showing dates in the proper format...

**The utils folder contains the business logic of our application.**

### widgets/
A folder to save all our global widgets in.

### main.dart
This is the main entry file of our application and gets executed when the application starts.
The following line run the complete application ```void main() => runApp(MyApp());```.
As a root widget of our app we'll use the ```MaterialApp``` widget which will provide a lot of basic functionality like theming, ...<br/>
[MaterialApp widget documentation.](https://api.flutter.dev/flutter/material/MaterialApp-class.html)<br/>
[Tutorial about the MaterialApp widget.](https://www.youtube.com/watch?v=ul4k2iondbo)<br/>
[More information about theming.](https://flutter.dev/docs/cookbook/design/themes)

### routes.dart
This file contains should contain a ```Router``` class which is responsible for selecting the correct route when the app asks for it.
When a route is requested we must return a ```MaterialRoute``` which handles platform specific transitions.<br/>
[More information about advanced routing in Flutter.](https://dev.to/nitishk72/flutter-advance-routing-and-navigator-part-1-547l)<br/>
[Passing data between screens](https://blog.usejournal.com/flutter-advance-routing-and-navigator-971c1e97d3d2)<br/>
[navigating through a navigation bottom bar](https://medium.com/flutter/getting-to-the-bottom-of-navigation-in-flutter-b3e440b9386)<br/>
[official flutter navigation documenatation](https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html)

## Spacing/sizing convetions
For the main part we'll use e 8x8 grid. Here are some example sizes: 8, 16, 32, 40, 48, 56, ...
For small widgets we can use a 4x4 grid.
[Material desing sizing specs](https://material.io/design/layout/spacing-methods.html#baseline-grid)

## Naming conventions
To keep our project as clean as possible we all should use the same naming conventions for files and folders as described below.

### File naming
Files should be named without using capital letters, different word should be connected using an underscore ```_```.

### Folder naming
Folders should be named according to the camelCase standard.

### Class naming
Classes should be named according to the PascalCase standard.

### Variable/Property naming
Variables or porperties should be named depending in there accessibility.

#### Private
In Dart private variables always start with an ```_```. As a convention we'll use a lowercase first letter.
```int _testNumber```

#### Public
These variables use camelCase.
```int testNumber```

#### Static
Should be camelCase with a private static starting with a ```_```.
```int testNumber``` or ```int _testNumber```

## Import structure
When importing classes at the top of our files we will make sure to separate the following using 1 empty line.

1. Dart imports
2. Flutter imports
3. 3th party package imports
4. Utils imports
5. Services imports
6. Models imports
7. Screen imports
8. Widget imports

## Mandatory plugins for VS Code
1. [Dart plugin](https://marketplace.visualstudio.com/items?itemName=Dart-Code.dart-code)
2. [Flutter plugin](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter)

## Handy plugins for VS Code
1. [Bracket Pair Colorizer 2](https://marketplace.visualstudio.com/items?itemName=CoenraadS.bracket-pair-colorizer-2)
2. [Material Icon Theme](https://marketplace.visualstudio.com/items?itemName=PKief.material-icon-theme)
3. [Flutter internationalize*](https://marketplace.visualstudio.com/items?itemName=apin.flutter-internationalize)

*Research needed.

## Pub packages we use
1. [Firebase Auth](https://pub.dev/packages/firebase_auth)
2. [Google sign in](https://pub.dev/packages/google_sign_in)
3. [Firebase Database](https://pub.dev/packages/firebase_database)
4. [FL Chart](https://pub.dev/packages/fl_chart)
5. [Connectivity](https://pub.dev/packages/connectivity)
6. [Bluetooth](https://pub.dev/packages/flutter_bluetooth_serial)
7. [Permission handler](https://pub.dev/packages/permission_handler)

## Database
For the database we use Firebase Authentication and Firebase Realtime Database.
1. ###### Firebase Authentication
    This is a service that Firebase provides to authenticate Google users to get access to the database. When a user logs on the app for the first time, the app asks if the user wants to accept the terms and policies of the app. Afterwards the user gets added in our FB Auth list with logged on users with a unique Google ID. The extra information will be saved on the FB Realtime DB wich will be explained in the next paragraph.
2. ###### Firebase Realtime Database
    This is another service that Firebase provides to store certain data to the database of your app. You can store integers, strings, floats and so on. To get more structure the data can be stored like a JSON-file. For example:<br/>
    >Family:
    >   Sons:
    >       Son1:
    >           Name: "Mark"
    >           Age: 21
    >       Son2:
    >           Name: "Arthur"
    >           Age: 16
    >   Daughters:
    >       Daughter1:
    >           Name: "Emily"
    >           Age: 18
    >   Dad:
    >       Name: "Michael"
    >       Age: 52
    >   Mom:
    >       Name: "Sarah"
    >       Age: 49
    For our database we have users wich contain user ID's. Those ID's contain their name, the ID of the user and the jumps.<br/>
    The jumps will have their own unique key once they get added after the user performed a jump on our product. The jump info include the height, date of the jump and probably some future related info that correspond to that jump. This way the app can easily find its way back to the certain jump info that the user requested in the app. We can use variable queries to request our data.
    **_But what about your user security?_**
    This is a very important subject in terms of using a database with personal info. In Firebase we can use security rules wich can be programmed manually on the Firebase Console. We can configure wich data can be accessed and which data is secured. We separate the actions of accessing a database in reading and writing data. But wich info we secure... That's a secret :wink:.