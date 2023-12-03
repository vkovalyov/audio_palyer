
/// Элемент связаного списка
class LinkedListItem<T> {
  /// значение ноды
  T value;
  /// ссылка на след ноду
  LinkedListItem<T>? next;
  /// ссылка на пред ноду
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

  /// хешкод объекта, влияет на сравниние [==]
  @override
  int get hashCode => Object.hash(value, prev, next);
}