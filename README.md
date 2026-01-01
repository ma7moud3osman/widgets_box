# SmartUIComponents Widget

The `widgets_box` A Flutter package for efficient UI state management, handling loading, empty views, content display, caching, and pull-to-refresh with customizable widgets.

<p>
    <a href="https://github.com/abdelrahmanghanem/widgets_box"><img src="https://img.shields.io/github/stars/abdelrahmanghanem/widgets_box?style=social" alt="Repo stars"></a>
    <a href="https://github.com/abdelrahmanghanem/widgets_box/commits/main"><img src="https://img.shields.io/github/last-commit/abdelrahmanghanem/widgets_box/main?logo=git" alt="Last Commit"></a>
    <a href="https://github.com/abdelrahmanghanem/widgets_box/pulls"><img src="https://img.shields.io/github/issues-pr/abdelrahmanghanem/widgets_box" alt="Repo PRs"></a>
    <a href="https://github.com/abdelrahmanghanem/widgets_box/issues?q=is%3Aissue+is%3Aopen"><img src="https://img.shields.io/github/issues/abdelrahmanghanem/widgets_box" alt="Repo issues"></a>
    <a href="https://github.com/abdelrahmanghanem/widgets_box/blob/main/LICENSE"><img src="https://badgen.net/github/license/abdelrahmanghanem/widgets_box" alt="License"></a>
</p>

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Widgets Usage](#widgets-usage)
    - [SmartCachedImages](#smartcachedimages)
    - [SmartEmptyWidget](#smartemptywidget)
    - [SmartLoadingWidget](#smartloadingwidget)
    - [SmartScreen](#smartscreen)
    - [SmartTagWidget](#smarttagwidget)
    - [SmartStatusWidget](#smartstatuswidget)
    - [MainButton](#mainbutton)
    - [MainTextField](#maintextfield)
- [Functions Usage](#functions-usage)
    - [ShowToast](#showtoast)
    - [HexColor](#hexcolor)
    - [Separated](#separated)
    - [showBottomSheetWidget](#showbottomsheet)
- [Extension Usage](#extension-usage)
    - [Extensions](#extensions)
- [Contributions](#contributions)
- [License](#license)

## Features

- Displays loading indicator when data is being fetched.
- Shows a custom or default empty screen when there is no data.
- Wraps the main content in a pull-to-refresh functionality.

## Installation

To use the `MainScreen` widget in your Flutter project, follow these steps:
1. Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  widgets_box: <latest_version>
```
2. to handle responsive

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // this very important
    MainWidgetsUtil.init(
      context,
      designSize: const Size(375, 812),
      minTextAdapt: true,
    );
    return MaterialApp(
      home: const HomeScreen(),
    );
  }
}
```




## Widgets Usage

Here is an example demonstrating how to use these parameters in the `MainScreen` widget:

### SmartScreen

```dart
    SmartScreen(
      isLoading: true, // Data is being loaded
      isEmpty: false, // Data is available
      child: YourMainContentWidget(), // Main content to display
      onRefresh: () async {
      // Logic for refreshing data
      },
      emptyWidget: CustomEmptyWidget(
        message: "No data available",
      ), // Optional empty widget
      message: "Please check back later.", // Optional message for empty state
    );
```

### SmartCachedImages

```dart
  SmartCachedImages(
    imageUrl: 'https://example.com/image.jpg',
  ),
``` 


### SmartEmptyWidget

```dart
  SmartEmptyWidget(
     message: 'The message of EmptyWidget',
  ),
```

### SmartLoadingWidget

```dart
    const SmartLoadingWidget()
```

<details>
<summary>Example Code </summary>

```dart
 SmartLoadingWidget(
    path: 'assets/animation.gif',
    loadingType: LoadingType.gif,
  )
```
```dart
  const SmartLoadingWidget(
    path: 'assets/animation1.json',
    loadingType: LoadingType.lottie,
  )
```
</details>

### SmartTagWidget

```dart
  SmartTagWidget(
    text: 'Tag Text',
    backgroundColor: Colors.red,
    textColor: Colors.white,
  )
```
### SmartStatusWidget

```dart
   const Card(
        child: SmartStatusWidget(
          text: '30%',
          backgroundColor: Colors.red,
          textColor: Colors.white,
            child: SizedBox(
            height: 200,
            width: 120,
              child: Column(
                children: [
                  SmartCachedImages(
                  imageUrl: '',
                  height: 120,
                  ),
                  Text('title'),
                  Text('subtitle'),
                ],
              ),
            ),
        ),
),
```

### MainButton

```dart
// Standard MainButton
MainButton(
  label: 'Click Me',
  onPressed: () {},
)

// MainButton with Icon
MainButton.icon(
  label: 'Next',
  icon: Icons.arrow_forward,
  iconType: IconType.icon,
  isIconEnd: true, // Icon appears after the label
  onPressed: () {},
)
```

### MainTextField

```dart
// Standard TextField
MainTextField(
  title: 'Username',
  hintText: 'Enter your username',
  controller: controller,
)

// Password TextField
MainTextField.password(
  title: 'Password',
  hintText: 'Enter your password',
  controller: passwordController,
)

// Email TextField
MainTextField.email(
  title: 'Email',
  controller: emailController,
)

// Phone TextField
MainTextField.phone(
  title: 'Phone Number',
  initialCountryCode: '+20',
  onChangedCountryCode: (code) {},
)
```


## Functions Usage

Here is an example demonstrating how to use these parameters in the `Functions` :

### ShowToast

<details>
<summary>Example Code </summary>

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StyledToast(
      backgroundColor: Colors.red,
      textStyle: const TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
      locale: const Locale('en', 'US'),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: false,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('home'),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () => showToastError(msg: 'show Toast Error'),
            child: const Text('show Toast Error'),
          ),
          TextButton(
            onPressed: () => showToastSuccess(msg: 'show Toast Success'),
            child: const Text('Show Toast Success'),
          ),
        ],
      ),
    );
  }
}
```
</details>

### HexColor

<details>
<summary>Example Code </summary>

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StyledToast(
      backgroundColor: Colors.red,
      textStyle: const TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
      locale: const Locale('en', 'US'),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: false,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('home'),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () => showToastError(msg: 'show Toast Error'),
            child: const Text('show Toast Error'),
          ),
          TextButton(
            onPressed: () => showToastSuccess(msg: 'show Toast Success'),
            child: const Text('Show Toast Success'),
          ),
        ],
      ),
    );
  }
}
```
</details>


## Extensions Usage

Here is an example demonstrating how to use these parameters in the `Extensions` :

### Extensions

```dart
  Text(
   context.isArabic? 'isArabic':'isEnglish',
    style: context.bodySmall.copyWith(
        color:context.isDark? Colors.white: Colors.black,
    ),
  ),
```





## Contributions
Feel free to contribute to this project.

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an [issue](https://github.com/abdelrahmanghanem/widgets_box/issues).  
If you fixed a bug or implemented a feature, please send a [pull request](https://github.com/abdelrahmanghanem/widgets_box/pulls).

<a href="https://github.com/abdelrahmanghanem/widgets_box/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=abdelrahmanghanem/widgets_box"  alt=""/>
</a>

Made with [contrib.rocks](https://contrib.rocks).