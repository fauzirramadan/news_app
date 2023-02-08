class Either<L, R> {
  late final dynamic _data;
  late final bool _failed;

  Either.success(R o) {
    _data = o;
    _failed = false;
  }
  Either.error(L o) {
    _data = o;
    _failed = true;
  }

  void when({
    required void Function(L failed) error,
    required void Function(R success) success,
  }) {
    if (_failed) {
      error(_data);
    } else {
      success(_data);
    }
  }

  Future<void> whenAsync({
    required Future<void> Function(L failed) error,
    required Future<void> Function(R success) success,
  }) async {
    if (_failed) {
      await error(_data);
    } else {
      await success(_data);
    }
  }
}
