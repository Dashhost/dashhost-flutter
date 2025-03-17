Dashhost Flutter provides components for generating SEO in flutter web apps that [Dashhost](https://dashhost.app) can interpret and serve to bots and crawlers.

## Features

* Drop-in replacement for `Text` widget using `DashText`
* Wrap widgets in `DashBox` to provide semantic layout
* Include `DashMetaTag` widgets to inject metatags to your page.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage


```dart
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: DashText("Dashhost Coded Example", dashTag: "h1")),
      body: Align(
        alignment: Alignment.center,s
        child: Column(
          children: [
            DashMetaTag.title("Dashhost Coded Example"),
            DashMetaTag.description("Welcome to the Dashhost Flutter Coded Example"),
            DashText("Welcome to the Dashhost Flutter Coded Example", dashTag: "h2"),
          ],
        ),
      ),
    );
  }
}
```

## Additional information

Dashhost Flutter also includes Dev Tools to preview how your page will be interpretted. You can enable them in the run function of your main.dart

```dart
void main() {
  DashDevTools().enable();
  runApp(const MyApp());
}
```
