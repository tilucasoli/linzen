class Cache<T> {
  T? _cache;

  Cache() : _cache = null;

  T? get cache => _cache;
  void setCache(T cache) => _cache = cache;
  void clearCache() => _cache = null;
  bool get isEmpty => _cache == null;
}
