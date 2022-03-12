import 'package:flame/components.dart';

class Node {
  Node? next;
  SpriteAnimationComponent data = SpriteAnimationComponent();
  void delete() {
    if (next == null) return;
    next!.delete();
    next = null;
  }
}

class Linkedlist {
  Node? head;
  void insert(SpriteAnimationComponent component) {
    if (isempty()) {
      head = Node();
      head!.data = component;
      return;
    }
    Node? temp = head;
    while (temp!.next != null) {
      temp = temp.next;
    }
    temp.next = Node();
    temp.next!.data = component;
  }

  bool isempty() {
    return (head == null);
  }

  void deleteall() {
    head!.delete();
    head = null;
  }
}
