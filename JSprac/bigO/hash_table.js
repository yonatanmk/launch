// hash table:
//   -pros
//     - Lookup: O(1)
//     - Insertion: O(1)
//   -used b/ very fast runtime (see ^^)
  // -cons:
  //   -data does not store references to other pieces of data in data structure
  // -practical uses:
  //   -email storage
  //   -user storage

function HashTable(size) {
  this.buckets = Array(size);
  this.numBuckets = this.buckets.length;
}

function HashNode(key, value, next) {
  this.key = key;
  this.value = value;
  this.next = next || null;
}

HashTable.prototype.hash = function(key) {
  let total = 0;
  for (let i = 0; i < key.length; i++) {
    total += key.charCodeAt(i);
  }
  return total % this.numBuckets;
};

HashTable.prototype.insert = function(key, value) {
  let index = this.hash(key);
  if (!this.buckets[index]) this.buckets[index] = new HashNode(key, value);
  else if (this.buckets[index].key === key) {
    this.buckets[index].value === value;
  }
  else {
    let currentNode = this.buckets[index];
    while (currentNode.next) {
      if (currentNode.next.key === key) {
        currentNode.next.value = value;   // allows you to edit values in hash table
        return;
      }
      currentNode = currentNode.next;
    }
    currentNode.next = new HashNode(key, value);
  }
};

HashTable.prototype.get = function(key) {
  let index = this.hash(key);
  if (!this.buckets[index]) return null;
  else {
    let currentNode = this.buckets[index];
    while (currentNode) {
      if (currentNode.key === key) return currentNode.value;
      currentNode = currentNode.next;
    }
    return null;
  }
};

HashTable.prototype.retrieveAll = function() {
  let output = [];
  for (let currentNode of this.buckets) {
    while (currentNode) {
      output.push(currentNode);
      currentNode = currentNode.next;
    }
  }
  return output;
};

let myHT = new HashTable(30);
myHT.insert('Dean', 'dean@gmail.com');
myHT.insert('Dane', 'dane@gmail.com');
myHT.insert('Dane', 'dane2@gmail.com');
myHT.insert('Megan', 'megan@gmail.com');
console.log(myHT.retrieveAll());
