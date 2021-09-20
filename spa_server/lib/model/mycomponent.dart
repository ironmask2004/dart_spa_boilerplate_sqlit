import 'dart:async';
import 'dart:io';

class MyComponent{
  /// Private constructor
  MyComponent._create() {
    print("_create() (private constructor)");

    // Do most of your initialization here, that's what a constructor is for
    //...
  }

  /// Public factory
  static Future<MyComponent> create() async {
    print("create() (public factory)");

    // Call the private constructor
    var component = MyComponent._create();

    // Do initialization that requires async
    //await component._complexAsyncInit();

    // Return the fully initialized object
    return component;
  }
}
/*
void main() async {
  var c = await MyComponent.create();

  print("done");
}
*

 */