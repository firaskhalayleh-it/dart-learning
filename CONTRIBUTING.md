# Contributing to Dart Learning Path

Thank you for your interest in contributing to this Dart learning curriculum! This guide will help you understand how to contribute effectively.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How to Contribute](#how-to-contribute)
- [Types of Contributions](#types-of-contributions)
- [Development Setup](#development-setup)
- [Contribution Guidelines](#contribution-guidelines)
- [Module Creation Guidelines](#module-creation-guidelines)
- [Testing Guidelines](#testing-guidelines)
- [Style Guide](#style-guide)
- [Submitting Changes](#submitting-changes)

## Code of Conduct

This project is committed to providing a welcoming and inclusive environment for all contributors. Please be respectful, professional, and constructive in all interactions.

## How to Contribute

### Reporting Issues

If you find problems with the curriculum:

1. Check existing issues to avoid duplicates
2. Create a new issue with:
   - Clear description of the problem
   - Which module/section is affected
   - Expected vs actual behavior
   - Your environment (Dart version, OS, etc.)

### Suggesting Improvements

We welcome suggestions for:
- New learning modules
- Improved explanations
- Additional exercises
- Better examples
- Technical corrections

## Types of Contributions

### 🐛 Bug Fixes
- Fix typos or grammatical errors
- Correct code examples
- Fix broken links or references

### 📝 Content Improvements
- Enhance explanations
- Add more examples
- Improve exercise descriptions
- Update outdated information

### ✨ New Content
- New learning modules
- Additional exercises
- New examples
- Supplementary documentation

### 🔧 Infrastructure
- Improve build scripts
- Update dependencies
- Enhance testing

## Development Setup

1. **Fork the repository**
   ```bash
   git clone https://github.com/YOUR-USERNAME/dart-learning.git
   cd dart-learning
   ```

2. **Install Dart SDK**
   - Ensure you have Dart SDK 3.2.0 or later
   - Install from [dart.dev](https://dart.dev/get-dart)

3. **Install dependencies**
   ```bash
   dart pub get
   ```

4. **Verify setup**
   ```bash
   dart run bin/list_tickets.dart
   dart test
   ```

## Contribution Guidelines

### General Principles

1. **Learner-First**: Always consider the learner's perspective
2. **Progressive Complexity**: Build concepts incrementally
3. **Practical Application**: Use realistic examples and exercises
4. **Modern Dart**: Use current Dart features and best practices
5. **Clear Documentation**: Explain concepts thoroughly

### Content Standards

- **Accuracy**: All code must compile and run correctly
- **Clarity**: Explanations should be clear and jargon-free
- **Completeness**: Cover concepts thoroughly with examples
- **Consistency**: Follow established patterns and terminology

## Module Creation Guidelines

When creating new modules, follow this structure:

```
modules/XX_module_name/
├── README.md           # Learning objectives and explanations
├── examples/           # Demonstration code
│   ├── basic_example.dart
│   └── advanced_example.dart
├── exercises/          # Practice problems
│   ├── exercise_1.dart
│   └── exercise_2.dart
└── solutions/          # Reference implementations
    ├── exercise_1_solution.dart
    └── exercise_2_solution.dart
```

### README.md Structure

Each module README should include:

1. **Learning Objectives** - What learners will achieve
2. **Key Concepts** - Core concepts with code examples
3. **Examples** - Reference to example files
4. **Exercises** - Practice problems description
5. **Testing Your Understanding** - Self-assessment checklist
6. **Next Steps** - Link to the next module
7. **Additional Resources** - External references

### Example Guidelines

- Include comprehensive comments
- Demonstrate one concept per example
- Use the Task & Ticket domain where possible
- Show both basic and advanced usage
- Include error handling where appropriate

### Exercise Guidelines

- Start with clear instructions
- Provide template code with TODO comments
- Include expected output examples
- Progress from simple to complex
- Relate to real-world scenarios

## Testing Guidelines

### Code Testing

All code examples and solutions must:

1. **Compile without warnings**
   ```bash
   dart analyze
   ```

2. **Pass all tests**
   ```bash
   dart test
   ```

3. **Follow linting rules**
   - Use the provided `analysis_options.yaml`
   - Fix all linter warnings

### Content Testing

Before submitting:

1. **Manual walkthrough** - Follow the module as a learner would
2. **Code execution** - Run all examples and verify output
3. **Exercise validation** - Ensure exercises can be completed
4. **Link checking** - Verify all links work

## Style Guide

### Dart Code Style

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use meaningful variable and function names
- Include comprehensive documentation comments
- Prefer explicit types for public APIs
- Use trailing commas for better diffs

### Documentation Style

- Use clear, concise language
- Write in second person ("you will learn")
- Use active voice
- Include code examples for all concepts
- Use consistent terminology throughout

### File Naming

- Use snake_case for file names
- Use descriptive names that indicate content
- Number exercises sequentially
- Include the module number in file paths

## Submitting Changes

### Pull Request Process

1. **Create a feature branch**
   ```bash
   git checkout -b feature/improve-module-05
   ```

2. **Make your changes**
   - Follow the guidelines above
   - Test thoroughly
   - Update documentation

3. **Commit with clear messages**
   ```bash
   git commit -m "Improve Module 5: Add async/await examples"
   ```

4. **Push and create PR**
   ```bash
   git push origin feature/improve-module-05
   ```

5. **Fill out PR template**
   - Describe what changed and why
   - Include testing performed
   - Reference any related issues

### Review Process

1. **Automated checks** - All CI checks must pass
2. **Content review** - Maintainers review for accuracy and clarity
3. **Learner testing** - Changes may be tested with real learners
4. **Approval and merge** - Approved changes are merged

### PR Guidelines

- Keep PRs focused and reasonably sized
- Include tests for new functionality
- Update documentation for changes
- Follow the established code style
- Respond promptly to review feedback

## Recognition

Contributors will be recognized in:
- Repository README
- Module acknowledgments (for significant contributions)
- Release notes

## Questions?

If you have questions about contributing:

1. Check existing issues and discussions
2. Create a new issue with the "question" label
3. Reach out to maintainers

Thank you for helping make Dart learning better for everyone! 🎯