abstract class TodoFailure {
  final String message;

  const TodoFailure(this.message);
}

class StorageFailure extends TodoFailure {
  const StorageFailure(String message) : super(message);
}
