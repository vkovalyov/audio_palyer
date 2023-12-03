import 'package:audio_player/core/linked_list/linked_list.dart';
import 'package:audio_player/core/linked_list/linked_list_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Тест-кейс класса LinkedListIte", () {
    test("Тест соединения узлов через next_item", () {
      var nodeA = LinkedListItem(value: 42, next: null, prev: null);
      var nodeB = LinkedListItem(value: 196, next: null, prev: null);
      nodeA.next = nodeB;

      expect(nodeA.next, nodeB);
      expect(nodeA.prev, null);
      expect(nodeB.next, null);
    });

    test("Тест соединения узлов через previous_item", () {
      var nodeA = LinkedListItem(value: 42, next: null, prev: null);
      var nodeB = LinkedListItem(value: 196, next: null, prev: null);
      nodeB.prev = nodeA;

      expect(nodeB.prev, nodeA);
      expect(nodeA.prev, null);
      expect(nodeB.next, null);
    });
  });

  group("Тест-кейс класса LinkedList", () {
    test("Тест метода len", () {
      LinkedList<int> list = LinkedList();

      list.append(1);
      list.append(2);
      expect(list.length, 2);

      list.remove(list.first);
      expect(list.length, 1);
    });

    test("Тест свойства last", () {
      int firstValue = 1;
      int secondValue = 2;

      LinkedList<int> list = LinkedList();

      list.append(firstValue);
      list.append(secondValue);

      expect(list.last.value, secondValue);
    });

    test("Тест метода append_left", () {
      int firstValue = 1;
      int secondValue = 2;

      LinkedList<int> list = LinkedList();

      list.appendLeft(firstValue);
      list.appendLeft(secondValue);

      expect(list.first.value, secondValue);
    });

    test("Тест метода append_right", () {
      int firstValue = 1;
      int secondValue = 2;

      LinkedList<int> list = LinkedList();

      list.appendRight(firstValue);
      list.appendRight(secondValue);

      expect(list.last.value, secondValue);
      expect(list.length, 2);
    });

    test("Тест метода append", () {
      int firstValue = 1;
      int secondValue = 2;

      LinkedList<int> list = LinkedList();

      list.append(firstValue);
      list.append(secondValue);

      expect(list.last.value, secondValue);
      expect(list.length, 2);
    });

    test("Тест метода in", () {
      int firstValue = 1;
      int secondValue = 2;
      LinkedList<int> list = LinkedList();
      list.append(firstValue);
      list.append(secondValue);
      final firstNode = list.first;

      expect(list.contains(firstNode), true);
    });

    test("Тест поддержки функции reversed", () {
      var list = [1, 2, 3, 4, 5, 6, 7];
      var reversedList = [7, 6, 5, 4, 3, 2, 1];

      LinkedList<int> linkList = LinkedList();

      for (var element in list) {
        linkList.appendRight(element);
      }

      var x = linkList.reversed;

      List<int> newReversedList = [];
      while (x.moveNext()) {
        newReversedList.add(x.current.value);
      }

      expect(listEquals(reversedList, newReversedList), true);
    });

    test("Тест индексации с Null, когда не нашли)", () {
      var list = [1, 2, 3, 4, 5, 6, 7];

      LinkedList<int> linkList = LinkedList();

      for (var element in list) {
        linkList.appendRight(element);
      }

      var item = linkList.getItem(22);

      expect(item?.value, null);
    });

    test("Тест индексации со значением, когда нашли", () {
      var list = [1, 2, 3, 4, 5, 6, 7];

      LinkedList<int> linkList = LinkedList();

      for (var element in list) {
        linkList.appendRight(element);
      }

      var item = linkList.getItem(2);

      expect(item?.value, 3);
    });

    test("Тест метода remove с Null", () {
      var list = [1, 2, 3, 4, 5, 6, 7];

      LinkedList<int> linkList = LinkedList();

      for (var element in list) {
        linkList.appendRight(element);
      }

      var item = LinkedListItem(value: 123, next: null, prev: null);
      var removedItem = linkList.remove(item);

      expect(removedItem, null);
      expect(linkList.length, 7);
    });

    test("Тест метода remove", () {
      var list = [1, 2, 3, 4, 5, 6, 7];

      LinkedList<int> linkList = LinkedList();

      for (var element in list) {
        linkList.appendRight(element);
      }

      var removedItem = linkList.remove(linkList.last);

      expect(removedItem, 7);
      expect(linkList.length, 6);
    });

    test("Тест метода insert", () {
      var list = [1, 2, 3, 4, 5, 6, 7];

      LinkedList<int> linkList = LinkedList();

      for (var element in list) {
        linkList.appendRight(element);
      }

      var node = linkList.getItem(3);
      linkList.insert(node!, 100);

      var insertedNode = linkList.getItem(4);

      expect(insertedNode!.value, 100);
      expect(linkList.length, 8);

    });
  });
}
