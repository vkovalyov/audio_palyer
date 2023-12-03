import 'package:audio_player/core/linked_list/linked_list.dart';
import 'package:audio_player/core/linked_list/linked_list_item.dart';

class PlayList<E> extends LinkedList<E> {
  LinkedListItem<E>? current;
  String id;
  String name;

  PlayList({
    required this.name,
    required this.id,
  });

  void playAll() {
    current = head;
  }

  void previousTrack() {
    if (current?.prev == null) {
      current = tail;
    } else {
      current = current?.prev;
    }
  }

  void nextTrack() {
    if (current?.next == null) {
      current = head;
    } else {
      current = current?.next;
    }
  }
}
