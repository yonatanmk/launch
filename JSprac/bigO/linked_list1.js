// Linked Lists Use cases:
// O(1):
//   -Adding/Removing head
//   -Adding/Removing Tail
// O(n):
//   -Searching through Linked List:
//
// Memory Management Benefits:
//   -data doesn't have to be stored together

function LinkedList() {
  this.head = null;
  this.tail = null;
}

LinkedList.prototype.addToHead = function(value) {
  let newNode = new Node(value, this.head, null);
  if (this.head) {
    this.head.prev = newNode;
  } else {
    this.tail = newNode;
  }
  this.head = newNode;
};

LinkedList.prototype.removeHead = function() {
  if (!this.head) return null;
  let val = this.head.value;
  this.head = this.head.next;
  if (this.head) {
    this.head.prev = null;
  } else {
    this.tail = null;
  }
  return val;
};

LinkedList.prototype.addToTail = function(value) {
  let newNode = new Node(value, null, this.tail);
  if (this.tail) {
    this.tail.next = newNode;
  } else {
    this.head = newNode;
  }
  this.tail = newNode;
};

LinkedList.prototype.removeTail = function() {
  if (!this.tail) return null;
  let val = this.tail.value;
  this.tail = this.tail.prev;
  if (this.tail) {
    this.tail.next = null;
  } else {
    this.head = null;
  }
  return val;
};

LinkedList.prototype.search = function(searchValue) {
  let currentNode = this.head;
  while (currentNode) {
    if (currentNode.value === searchValue) {
      return currentNode.value
    }
    currentNode = currentNode.next;
  }
  return null
};

LinkedList.prototype.indexOf = function(value) {
  let currentNode = this.head;
  let currentIndex = 0
  let output = []
  while (currentNode) {
    if (currentNode.value === value) {
      output.push(currentIndex)
    }
    currentNode = currentNode.next;
    currentIndex++;
  }
  // if (output.length === 0) return null;
  return output
};

function Node (value, next, prev) {
  this.value = value;
  this.next = next;
  this.prev = prev;
}

var LL = new LinkedList();

LL.addToTail(3)
LL.addToTail(5)
LL.addToTail(3)
LL.addToTail(8)

console.log(LL.indexOf(1))
