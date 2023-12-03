import 'package:audio_player/core/linked_list/linked_list_item.dart';

/// Итератор для связаного списка
class LinkedListIterator<E> implements Iterator<LinkedListItem<E>> {
  final LinkedListItem<E>? _node;

  LinkedListIterator(this._node) {
    _currentNode = _node;
  }

  bool _firstPass = true;
  LinkedListItem<E>? _currentNode;

  @override
  LinkedListItem<E> get current => _currentNode!;

  @override
  bool moveNext() {
    if (_currentNode == null) return false;
    if (_firstPass) {
      _currentNode = current;
      _firstPass = false;
    } else {
      _currentNode = _currentNode?.next;
    }

    return _currentNode != null;
  }
}
