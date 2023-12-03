import 'package:audio_player/core/Iterator/list_ierator.dart';
import 'package:audio_player/core/Iterator/reverse_list_iterator.dart';
import 'package:audio_player/core/linked_list/linked_list_item.dart';

class LinkedList<E> extends Iterable<LinkedListItem<E>> {
  LinkedListItem<E>? head;
  LinkedListItem<E>? tail;

  int _length = 0;

  @override
  bool get isEmpty => head == null;

  @override
  int get length => _length;

  LinkedListItem? get lastElement => tail;

  E? _removeLeft() {
    if (head != null) {
      final result = head?.value;

      if (head == tail) {
        head = null;
        tail = null;
      } else {
        head = head?.next;
        head?.prev = null;
      }
      return result;
    }

    return null;
  }


  LinkedListItem<E>? insert(LinkedListItem<E> previous, E value) {
    if (tail == previous) {
      append(value);
      return tail!;
    }

    if (head == previous) {
      appendLeft(value);
      return head;
    }

    if (contains(previous)) {
      final newNode = LinkedListItem(
        value: value,
        next: previous.next,
        prev: previous,
      );

      previous.next = newNode;

      _increment();
      return newNode;
    } else {
      return null;
    }
  }

  E? _removeRight() {
    if (tail != null) {
      final result = tail?.value;
      if (head == tail) {
        head = null;
        tail = null;
      } else {
        tail = tail?.prev;
        tail?.next = null;
      }
      return result;
    }
    return null;
  }

  E? remove(LinkedListItem node) {
    if (node == head) {
      _decrement();
      return _removeLeft();
    } else if (node == tail) {
      _decrement();
      return _removeRight();
    } else {
      if (contains(node)) {
        node.prev?.next = node.next;
        node.next?.prev = node.prev;
        _decrement();
        return node.value;
      } else {
        return null;
      }
    }
  }

  void _increment() {
    _length = _length + 1;
  }

  void _decrement() {
    if (_length > 0) {
      _length = _length - 1;
    }
  }

  void append(E value) => appendRight(value);

  void appendLeft(E value) {
    if (isEmpty) {
      final newNode = LinkedListItem(value: value, next: null, prev: null);
      head = newNode;
      tail = newNode;
    } else {
      final newNode = LinkedListItem(value: value, next: head, prev: null);
      head?.prev = newNode;
      head = newNode;
    }
    _increment();
  }

  void appendRight(E value) {
    if (tail == null) {
      final newNode = LinkedListItem(value: value, next: null, prev: null);
      tail = newNode;
      head = newNode;
    } else {
      final newNode = LinkedListItem(value: value, next: null, prev: tail);
      tail?.next = newNode;
      tail = newNode;
    }

    _increment();
  }

  @override
  bool contains(Object? element) {
    var currentNode = head;

    while (currentNode != null) {
      if (element == currentNode) return true;

      currentNode = currentNode.next;
    }
    return false;
  }

  @override
  Iterator<LinkedListItem<E>> get iterator => LinkedListIterator(this.head);

  Iterator<LinkedListItem<E>> get reversed =>
      ReverseLinkedListIterator(this.tail);

  LinkedListItem<E>? next(LinkedListItem<E> node) {
    return node.next;
  }

  void nodeAt(E value, int index) {
    final currentNode = getItem(index);

    if (currentNode != null) {
      if (currentNode == head) {
        appendLeft(value);
      } else {
        final prev = currentNode.prev;
        final newNode = LinkedListItem(
          value: value,
          next: currentNode,
          prev: prev,
        );

        currentNode.prev?.next = newNode;
        currentNode.prev = newNode;
        _increment();
      }
    } else {
      appendRight(value);
    }
  }

  LinkedListItem<E>? getItem(int index) {
    int startIndex = 0;

    final it = iterator;
    while (it.moveNext()) {
      if (startIndex == index) {
        return it.current;
      }
      startIndex++;
    }

    return null;
  }
}
