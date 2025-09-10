/// Example showing different types of comments in Dart
/// 
/// This file demonstrates the three types of comments available in Dart
/// and when to use each one.

// Import the dart:core library (though this is imported by default)
import 'dart:core';

/// Main function demonstrating comment types
/// 
/// Documentation comments like this one start with /// and are used
/// to document functions, classes, and other public APIs.
/// They can contain markdown formatting and will appear in
/// generated documentation.
void main() {
  // Single line comments start with // and continue to the end of the line
  // They're perfect for brief explanations or notes
  print('Demonstrating comments in Dart');
  
  /*
    Multi-line comments start with /* and end with */
    They can span multiple lines and are useful for:
    - Longer explanations
    - Temporarily disabling blocks of code
    - Adding detailed documentation
    - ASCII art (if you're into that sort of thing!)
  */
  
  print('Check the source code to see different comment types!');
  
  // TODO: Add more examples later
  // NOTE: This is a common pattern for leaving notes to yourself
  // FIXME: Remember to update this when we add new features
  
  /// Documentation comments can also appear before variables
  /// This variable stores our application name
  final String appName = 'Task Tracker';
  print('Application: $appName');
}

/// A helper function to demonstrate documentation comments
/// 
/// This function doesn't do much, but shows how documentation
/// comments work with functions.
/// 
/// Returns a greeting message.
String getGreeting() {
  return 'Hello from a documented function!';
}