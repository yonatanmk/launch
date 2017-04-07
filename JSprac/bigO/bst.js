// Binary Search Tree properties:
//   -pros
//     - very fast to search through and retrieve data from (binary search - O(log n))
//     - very quick to insert and delete data from binary tree (binary search - O(log n))
//       -most performant ( e.g. O(log n) ) if tree is balanced
//   -good for dictionary, phonebook, etc

function BST(value) {
  this.value = value;
  this.left = null;
  this.right = null;
}


BST.prototype.insert = function (value) {
  if (value <= this.value) {
    if (!this.left) this.left = new BST(value);
    else this.left.insert(value);
  }
  else {
    if (!this.right) this.right = new BST(value);
    else this.right.insert(value);
  }
};

BST.prototype.contains = function(value) {
  if (value === this.value) return true;
  else if (value < this.value) {
    if (!this.left) return false;
    else return this.left.contains(value);
  }
  else {
    if (!this.right) return false;
    else return this.right.contains(value);
  }
};

BST.prototype.depthFirstTraversal = function(iteratorFunc, order) {
  if (order === 'pre-order') iteratorFunc(this.value);
  if (this.left) this.left.depthFirstTraversal(iteratorFunc, order);
  if (order == 'in-order') iteratorFunc(this.value);
  if (this.right) this.right.depthFirstTraversal(iteratorFunc, order);
  if (order === 'post-order') iteratorFunc(this.value);
};
//different depthFirstTraversal types:
  // in-order: useful for getting data from bst
      // touches every node in order from least to greatest
      // most used traversal method
  // pre-order: useful for copying a bst
  // post-order: useful for safely deleting nodes from bst b/c starts at lowest and works its way up

BST.prototype.breadthFirstTraversal = function(iteratorFunc) {
  let stack = [this]; // first in  - first out
  while (stack.length) {
    let treeNode = stack.shift();
    iteratorFunc(treeNode.value);
    if (treeNode.left) stack.push(treeNode.left);
    if (treeNode.right) stack.push(treeNode.right);
  }
};

// breadthFirstTraversal uses
//   -storing hierarchies

BST.prototype.getMinVal = function() {
  if (!this.left) return this.value;
  else return this.left.getMinVal();
};

BST.prototype.getMaxVal = function() {
  if (!this.right) return this.value;
  else return this.right.getMaxVal();
};


let bst = new BST(50);
bst.insert(30);
bst.insert(70);
bst.insert(100);
bst.insert(60);
bst.insert(59);
bst.insert(20);
bst.insert(45);
bst.insert(35);
bst.insert(85);
bst.insert(105);
bst.insert(10);

// console.log(bst.left.right.value);
// console.log(bst.contains(10));
// bst.depthFirstTraversal((value)=>console.log(value), 'in-order');
// bst.depthFirstTraversal((value)=>console.log(value), 'post-order');
// bst.breadthFirstTraversal((value)=>console.log(value));

console.log(bst.getMinVal());
console.log(bst.getMaxVal());
