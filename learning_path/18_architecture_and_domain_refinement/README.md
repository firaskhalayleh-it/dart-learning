# 18 – Architecture & Domain Refinement

## Goals
* Evolve from ad-hoc scripts to layered architecture
* Separate domain (pure) from infrastructure (IO)
* Introduce application services / use cases

## Layers (Conceptual)
```
/bin            # entrypoints (CLI)
/lib
  /domain       # entities, value objects, repositories (interfaces)
  /app          # use cases, coordinators
  /infra        # impls: file store, http client
  /util         # shared helpers
```

## Use Case Example
```dart
class CreateTaskUseCase {
  final TaskRepository repo;
  const CreateTaskUseCase(this.repo);
  Future<Task> call(String title) async {
    final trimmed = title.trim();
    if (trimmed.isEmpty) { throw FormatException('Title required'); }
    final task = Task.newTodo(trimmed);
    return repo.create(task);
  }
}
```

## Dependency Flow
* Domain: zero outward dependencies
* App: depends on domain abstractions
* Infra: depends on external packages & implements domain contracts
* Entry: wires everything

## Practice
1. Introduce a `ListOpenTasksUseCase` applying filters.
2. Add adapter that converts CLI args into use case calls.
3. Replace direct logging with an injected logger interface.

## Checklist
* [ ] No infra import inside domain layer
* [ ] Use cases remain thin & deterministic (aside from repo calls)
* [ ] Wiring centralized (composition root)

## Finish Line
You now have a pure Dart path: from language fundamentals → architectural maturity.

Next explorations: gRPC, code generation (build_runner), isolates pooling, caching strategies, plugin/package authoring.
