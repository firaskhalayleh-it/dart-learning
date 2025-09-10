/// Example demonstrating imports and library usage in Dart
/// 
/// This file shows how to import and use different Dart libraries.

// Import core libraries
import 'dart:math';  // For mathematical operations and random numbers
import 'dart:io';    // For input/output operations (like reading files)

/// Main function demonstrating library usage
void main() {
  print('Demonstrating Dart library imports');
  print('======================================');
  
  // Using dart:math library
  demonstrateMathLibrary();
  
  print(''); // Empty line for spacing
  
  // Using dart:io library  
  demonstrateIoLibrary();
}

/// Function demonstrating the dart:math library
void demonstrateMathLibrary() {
  print('Using dart:math library:');
  
  // Create a random number generator
  final random = Random();
  
  // Generate some random numbers
  final randomInt = random.nextInt(100);  // Random integer 0-99
  final randomDouble = random.nextDouble(); // Random double 0.0-1.0
  
  print('Random integer (0-99): $randomInt');
  print('Random double (0.0-1.0): $randomDouble');
  
  // Use some math constants and functions
  print('Value of PI: ${pi.toStringAsFixed(6)}');
  print('Square root of 16: ${sqrt(16)}');
  print('2 to the power of 8: ${pow(2, 8)}');
  
  // Find min and max
  final numbers = [15, 23, 8, 42, 4];
  print('Numbers: $numbers');
  print('Minimum: ${numbers.reduce(min)}');
  print('Maximum: ${numbers.reduce(max)}');
}

/// Function demonstrating the dart:io library
void demonstrateIoLibrary() {
  print('Using dart:io library:');
  
  // Get platform information
  print('Platform: ${Platform.operatingSystem}');
  print('Number of processors: ${Platform.numberOfProcessors}');
  
  // Get current directory
  final currentDir = Directory.current;
  print('Current directory: ${currentDir.path}');
  
  // Environment variables (be careful - these might not exist!)
  final path = Platform.environment['PATH'];
  if (path != null) {
    print('PATH environment variable exists (length: ${path.length})');
  } else {
    print('PATH environment variable not found');
  }
  
  // Note: We're not reading files here to keep the example simple
  // and avoid dependencies on file system structure
  print('File I/O operations would be demonstrated here in a real app');
}