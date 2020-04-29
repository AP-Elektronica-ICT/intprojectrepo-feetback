# Feetback

This app will be used to connect to a mat that can measure your jump height.

Contributors:
- [Alan Maene](https://github.com/AlanMaene)
- [Ben Dupont](https://github.com/ben-student)
- [Olivier Verhaegen](https://github.com/OlivierVerhaegen)
- [Pieter-Jan Lanneer](https://github.com/PJGitLan)
- [Thibaut Weekx](https://github.com/W33KX)

Calculating jump height from airtime: <br/>
```height = ((AirTime/2)*(AirTime/2)*0.5*9.81);```

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
[--> Firebase Authentication](#firebase-authentication) <br/>
[--> Firebase Realtime Database](#firebase-realtime-database) <br/>
[General Data Protection Regulation (GDPR)](#general-data-protection-regulation-gdpr) <br/>

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
8. [Flutter Markdown](https://pub.dev/packages/flutter_markdown)
9. [Jiffy](https://pub.dev/packages/jiffy)

## Database
For the database we use Firebase Authentication and Firebase Realtime Database.
1. ###### Firebase Authentication
    This is a service that Firebase provides to authenticate Google users to get access to the database. When a user logs on the app for the first time, the app asks if the user wants to accept the terms and policies of the app. Afterwards the user gets added in our FB Auth list with logged on users with a unique Google ID. The extra information will be saved on the FB Realtime DB wich will be explained in the next paragraph.
2. ###### Firebase Realtime Database
    This is another service that Firebase provides to store certain data to the database of your app. You can store integers, strings, floats and so on. To get more structure the data can be stored like a JSON-file. For example:<br/>
    >```
    >Family:
    >       Sons:
    >           Son1:
    >               Name: "Mark"
    >               Age: 21
    >           Son2:
    >               Name: "Arthur"
    >               Age: 16
    >       Daughters:
    >           Daughter1:
    >               Name: "Emily"
    >               Age: 18
    >       Dad:
    >           Name: "Michael"
    >           Age: 51
    >       Mom:
    >           Name: "Sarah"
    >           Age: 49
    >```
    For our database we have users wich contain user ID's. Those ID's contain their name, the ID of the user and the jumps.<br/>
    The jumps will have their own unique key once they get added after the user performed a jump on our product. The jump info include the height, date of the jump and probably some future related info that correspond to that jump. This way the app can easily find its way back to the certain jump info that the user requested in the app. We can use variable queries to request our data.<br/><br/>
    The layout of our database looks like this:<br/>
    ![Image of database-layout](https://github.com/AP-Elektronica-ICT/intprojectrepo-feetback/blob/documentation/assets/database.PNG) <br/>
    **_But what about your user security?_**<br/>
    This is a very important subject in terms of using a database with personal info. In Firebase we can use security rules wich can be programmed manually on the Firebase Console. We can configure wich data can be accessed and which data is secured. We separate the actions of accessing a database in reading and writing data. But wich info we secure... That's a secret :wink:.

## General Data Protection Regulation (GDPR)
GDPR is enforced from May 25th 2018. It is designed to protect user data storage and usage, and to ensure that the user is in control of their data, rather than companies being in charge of user data.

### Definitions
**Data Controller:** This is the entity that determines the purpose for and means of collecting and processing personal data. If you own a website or mobile app, and you’re deciding what is collected, how it is collected, and for what purpose, you are a Data Controller.

<br/>

**Data Processor:** A Data Processor is an organization that processes personal data on behalf of a data controller. For example, third-party services that plug into your website or app, such as Analytics (Google Analytics, KISSMetrics), Cloud Services (AWS), that access or host your customer data.

<br/>

**Data Subject:** a natural person whose data is processed. For example, an app user or a website visitor. <br/>

A full list of GDPR definitions can be found in [Article 4](https://gdpr-info.eu/art-4-gdpr/) of the regulation. <br/>

[Source](https://www.mobiloud.com/blog/gdpr-compliant-mobile-app/) <br/>
[Full GDPR](https://gdpr-info.eu/) <br/>

### Application features
- Provide an opt-in screen when the application starts for the first time. It should be possible to decline (if the user declines a pop-up will inform the user that use of this application isn't possible without their consent and will close the app after the user confirms.)
- Opt-in check boxes can't be pre-selected.
- When asking for specific pieces of data, individual options for obtaining consent should be shown.
- Provide an easy way to opt-out in the application settings.

### Privacy policy (opt-in)
Hi new user! Please read this policy thoroughly before using this application. At **Feetback** we value your privacy and thus will only use the necessary data for the application to function. <br/>

#### Guides
- [Google guide for end-user opt-in](https://firebase.google.com/support/privacy#guides_for_enabling_opt-in_for_end-user_personal_data_processing)

### Data processors
- Google Firebase [Data Processing and Security Terms](https://firebase.google.com/terms/data-processing-terms)

#### Data storage and processing locations
- Google US data centers

#### Data encryption
The users data is encrypted in transit using HTTPS. Furthermore the user data is also encrypted at rest.

#### Security practices
To keep personal data safe, we employ extensive security measures to minimize access:
- We Restrict access to a select employees who have business purpose to access personal data.
- We log employee access to systems that contain personal data.

### Summary of data wa save
- End users Google Authentication token: this token makes it possible for you to log in using your Google account.
- End users name, email.
- Data generated by the end user within the **Feetback** application.

### User rights
1. [The Right to Information](#the-right-to-information)
2. [The Right of Access](#the-right-of-access)
3. [The Right of Rectification](#the-right-of-rectification)
4. [The Right of Erasure](#the-right-of-erasure)
5. [The Right to Restriction of Processing](#the-right-to-restriction-of-processing)
6. [The Right to Data Portability](#the-right-to-data-portability)
7. [The Right to Object](#the-right-to-object)
8. [The Right to Avoid Automated Decision-Making](#the-right-to-avoid-automated-descision-making)

#### The Right to Information
The first of the eight rights lies in Articles 13 and 14 of the GDPR. [Article 13](https://gdpr-info.eu/art-13-gdpr/) refers to **information that you must provide** when you collect personal data directly from data subjects. <br/>

<br/>

[Article 14](https://gdpr-info.eu/art-14-gdpr/) covers **your responsibilities** when you obtain data about the data subject **from a third party** or **indirectly**. <br/>

**Article 13** holds that you must provide the following information when you collect their data (**not after**). <br/>

<br/>

**Article 14** states that you need to provide the same information even if you don't collect the data directly from a data subject but from a third party. A data subject has the right to ask what personal data you collect. <br/>

##### Controller identity and contact details and those of the controller's EU representative (if applicable).
AP Hogeschool <br/>
Campus Spoor Noord - Ellermanstraat <br/>
Ellermanstraat 33, 2060 Antwerpen, Belgium <br/>
[onthaal.ell@ap.be](mailto:onthaal.ell@ap.be) <br/>
[+32 3 220 33 00 (mo-fr 8 a.m. - 6 p.m.)](tel:+3232203300)

##### Data Protection Officer contact details (if a DPO was appointed).
No DPO is appointed, please contact us using the given contact information.

##### Legal basis for processing an purpose of porcessing.
The data collected is used for educational purposes only.

##### Country where the processor occurs.
Belgium, Finland.

##### [Grounds of Legitimate intrests](https://ec.europa.eu/info/law/law-topic/data-protection/reform/rules-business-and-organisations/legal-grounds-processing-data/grounds-processing/what-does-grounds-legitimate-interest-mean_en) of the processor and third parties.
The data collected is used for educational purposes only.

##### Any recipients of personal data.
The data collected is for the purpose of an international project. This project is hosted between AP University College in Belgium and Oulu University of Applied Sciences in Finland. AP University College is the controller of the data, but the data may be sent to the Oulu University of Applied Sciences in Finland. <br/>

Oulu University of Applied Sciences <br/>
Linnanmaa Campus <br/>
Yliopistokatu 9, 90570 Oulu, Finland <br/>
[international@oamk.fi](mailto:international@oamk.fi) <br/>
[020 611 0200 (mo-fr 8 a.m. - 4:15 p.m.)](tel:0206110200)

##### Any intention to transfer personal data outside the specified processing place and to a third country (particulary if the country is outside the EU).
[see above](#any-recipients-of-personal-data)

##### Data retention policy (how log data is stored).
The data will be stored until you request to delete it or until the project is done. The project ends lastly on january 1st 2021.

##### Explenation of rights to rectification, erasure, resrtiction of processing and portabililty.
[see: User rights](#user-rights)

##### Explenation of right to withdraw consent.
As a user you have the right to withdraw consent, you can do this in the application settings.

##### Explanation of right to complain to the relevant supervisory authority.
As a user you have the right to complain about the use of your data. Contact us at [onthaal.ell@ap.be](mailto:onthaal.ell@ap.be). Please refer tho the ICT-electronics department.

##### If data collection is a contractual requirement and any consequences.
There are no contractual requirements to the use of this application.

##### Existence of profiling and any other types of automated descision-making and information about the logic behind them.
Your data may be used to compare your jumps to the jumps of other users. This is or could become a feature of the application. If you don't want your data to be shared you can specify this in the applications settings.

#### The Right of Access
[Article 15](https://gdpr-info.eu/art-15-gdpr/) outlines the first named right found in the GDPR: **The right to access**. This means that the data subject may access the personal data belonging to them. <br/>

<br/>

##### Your rights and how to use them
As a user you have the right to ask **why** and **how** your data is processed, **categories** of personal data involved, **who** sees the data (including countries outside the EU), **how long** your data is stored, how to exercise your rights, **source** of the data collected about you and wether we use **automated descision-making**. You may request a copy of your personal information once each month without any fees. You also may ask us to limit the use of your personal data or even delete it. <br/>

You also have the right to complain to the Belgian privacy regulator should you feel your rights or the law has been compromised. <br/>

<br/>

###### How to get your data
1. Send us an email at [onthaal.ell@ap.be](mailto:onthaal.ell@ap.be)
2. Use subject: "Request for personal data"
3. Refer to the ICT-electronics department.
4. Specify what data you would want to recieve.
5. We'll get into touch in 48 hours.

#### The Right of Rectification
[Article 16](https://gdpr-info.eu/art-16-gdpr/), the right to rectification, provides European data subjects with the right to change or modify the data they provide you when they believe the data is inaccurate or out-of-date. You need to provide this "without undue delay." Why is holding accurate data so important for you and your data subjects? Because incorrect data threatens the privacy of other individuals.

For example, if you hold data subject phone numbers, you need to acknowledge that people change their phone numbers from time to time. If you hold old phone numbers that were then given away to new customers, you risk contacting a customer who didn't provide consent.

Holding data and contacting customers without their consent is a GDPR violation.<br/>

<br/>

As a user you have the right to adjust inaccurate or ou-of-date data. This can be done in the application settings. <br/>

#### The Right of Erasure
[Article 17](https://gdpr-info.eu/art-17-gdpr/) describes the user right to erasure, which is better known as the right to be forgotten. When you make the decision to erase a data subject's data according to the right to erasure, you also need to share the request. All other controllers or processors with whom you have a contract also need to be aware of the erasure so that they can also erase:
- Links to ...
- Copies of...
- Replication of personal data

<br/>

As a user you have the right to request deletion of your data. You can do this by deleting your account in the application settings.

#### The Right to Restriction of Processing
[Article 18](https://gdpr-info.eu/art-18-gdpr/) outlines the data subject's right to request the restriction of processing under certain conditions. That means you must temporarily stop processing their data as requested as long as their requests meets one of the following:
- The data subject contests the accuracy of the data
- The data subject objects to unlawful processing and the data subject prefers you to restrict the processing rather than erasing their data
- The data controller does not need the data for processing but they need to keep the data pursuant to the "establishment, exercise, or defence of a legal claim"
Article 18(3) states that if you temporarily stop processing data, then you must inform the data subject before lifting the restriction and resuming the processing, if you choose to do so.

#### The Right to Data Portability
The right to data portability outlined in [Article 20](https://gdpr-info.eu/art-20-gdpr/) refers to the data subject's right to receive the personal data held by the data controller in a commonly used format and send the data to another controller or use it for their personal purposes, under certain circumstances. <br/>

<br/>

As a user you have the right to recieve your personal data in a structured, machine readable and safe way.

#### The Right to Object
[Article 21](https://gdpr-info.eu/art-21-gdpr/) outlines what is known as the right to object. In simple terms, it says that data subjects have the right to object to your data processing, including profiling, when it is on relevant grounds. <br/>

<br/>

As a user you have the right to object the use of your personal data, at any stage. You also have the right to object to out using of your personal data where our reason is based on legitimate intrests. We will have to stop processing until we can establish that we have compelling legitimate grounds which override your intrests, rights and freedoms, or that we need to continue using it for the establishment, exercise, or defense of legal claims.

#### The Right to Avoid Automated Decision-Making
The eighth and final right offered by the GDPR lies in [Article 22](https://gdpr-info.eu/art-22-gdpr/): Automated decision-making, including profiling. It says: "The data subject shall have the right not to be subject to a decision based solely on automated processing, including profiling, which produces legal effects concerning him or her or similarly affects him or her". <br/>

<br/>

As a user you have the right to decline automated decision-making, there are three exception though:
1. When automated decision-making is necessary to enter into or complete a contract.
2. When we have the authorization from the EU or a Member State and uses safeguards to protect the subject's interests and freedom.
3. When you give explicit consent.
We don't use automated descision makeing so don't worry.
