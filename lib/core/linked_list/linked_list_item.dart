
class LinkedListItem<T> {
  T value;
  LinkedListItem<T>? next;
  LinkedListItem<T>? prev;

  LinkedListItem({
    required this.value,
    required this.next,
    required this.prev,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is LinkedListItem &&
        other.runtimeType == runtimeType &&
        other.value == value &&
        other.prev == prev &&
        other.next == next;
  }


  @override
  int get hashCode => Object.hash(value, prev, next);
}