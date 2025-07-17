// lib/core/services/dependency_injection.dart

class DependencyInjection {
  static final DependencyInjection _instance = DependencyInjection._internal();
  factory DependencyInjection() => _instance;
  DependencyInjection._internal();

  final Map<Type, dynamic> _services = {};

  void registerSingleton<T>(T service) {
    _services[T] = service;
  }

  void registerFactory<T>(T Function() factory) {
    _services[T] = factory;
  }

  T get<T>() {
    final service = _services[T];

    if (service == null) {
      throw Exception('Service of type $T is not registered');
    }

    if (service is Function) {
      return service() as T;
    }

    return service as T;
  }

  bool isRegistered<T>() {
    return _services.containsKey(T);
  }

  void reset() {
    _services.clear();
  }
}

// Helper function for easier access
T getIt<T>() => DependencyInjection().get<T>();
