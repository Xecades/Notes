# CS 61B: Data Structures

**📖 COURSE-STARTED-AT**: 2023-12-5

**🔮 COURSE-FINISHED-AT**: Nope, haven't finished yet.

**🔗 COURSE-SITE**: [datastructur.es](https://datastructur.es/)

---

## Linked List

It is so simple that I don't want to write it down.

---

## Disjoint Set

A disjoint set records connectivity. In the example below, `2` and `3` are connected while `5` and `7` are not.

![Disjoint Set](img/disjoint-set.png)

### Interface

```java
public interface DisjointSet {
    /**
     * Connects two elements, a and b.
     * If a and b are already connected, do nothing.
     */
    void connect(int a, int b);

    /**
     * Returns true iff a and b are connected.
     * Connectivity is transitive.
     */
    boolean isConnected(int a, int b);
}
```

---

### Implementation

```java
public class DisjointSetImpl implements DisjointSet {
    /**
     * If parent[i] >= 0, then parent[i] is the parent of i.
     * If parent[i] < 0, then i is a root node.
     *   The absolute value of parent[i] is the size of the tree rooted at i.
     *   The size is defined as the number of nodes in the tree.
     */
    private int[] parent;

    /**
     * Creates a disjoint set of n elements.
     * Initially, each element is in its own set.
     */
    public DisjointSetImpl(int n) {
        parent = new int[n];
        for (int i = 0; i < n; i++)
            parent[i] = -1;
    }

    @Override
    public void connect(int a, int b) {
        int rootA = root(a), rootB = root(b);
        int sizeA = -parent[rootA], sizeB = -parent[rootB];
        
        if (rootA == rootB) return;

        // Always attach the smaller tree to the larger tree.
        if (sizeA < sizeB) {
            parent[rootA] = rootB;
            parent[rootB] -= sizeA;
        } else {
            parent[rootB] = rootA;
            parent[rootA] -= sizeB;
        }
    }

    @Override
    public boolean isConnected(int a, int b) {
        return root(a) == root(b);
    }

    /**
     * Returns the root of the tree that i belongs to.
     */
    private int root(int i) {
        while (parent[i] >= 0)
            i = parent[i];
        return i;
    }
}
```

---

### Time Complexity

Time complexity of function `root` is determined by the height of the tree. Since we always attach the smaller tree to the larger tree, only by doubling $n$ can we increase the height of the tree by $1$. Therefore, the complexity of `root` is $\Theta(\log n)$.

Both `connect` and `isConnected` take the same time as `root`, which is $\Theta(\log n)$.

---

## Binary Search Tree

### Interface

```java
public interface BST<T extends Comparable<T>> {
    /**
     * Returns true iff the BST contains the given key.
     */
    boolean contains(T key);

    /**
     * Inserts the given key into the BST.
     * If the key is already in the BST, do nothing.
     */
    void insert(T key);

    /**
     * Removes the given key from the BST.
     * If the key is not in the BST, do nothing.
     */
    void remove(T key);
}
```

---

### Implementation

```java
public class BSTImpl<T extends Comparable<T>> implements BST<T> {
    /**
     * A node in the BST.
     */
    private class Node {
        T value;
        Node left, right;

        Node(T v) { value = v; }
    }

    private Node root;

    @Override
    public boolean contains(T key) {
        return contains(root, key);
    }

    private boolean contains(Node node, T key) {
        if (node == null)
            return false;
        int cmp = node.value.compareTo(key);
        if (cmp < 0) return contains(node.left, key);
        if (cmp > 0) return contains(node.right, key);
        return true;
    }

    @Override
    public void insert(T key) {
        root = insert(root, key);
    }

    private Node insert(Node node, T key) {
        if (node == null)
            return new Node(key);
        int cmp = node.value.compareTo(key);
        if (cmp < 0) node.left = insert(node.left, key);
        if (cmp > 0) node.right = insert(node.right, key);
        return node;
    }

    @Override
    public void remove(T key) {
        root = remove(root, key);
    }

    private Node remove(Node node, T key) {
        if (node == null)
            return null;
        int cmp = node.value.compareTo(key);
        if (cmp < 0) node.left = remove(node.left, key);
        if (cmp > 0) node.right = remove(node.right, key);
        if (cmp == 0) {
            if (node.left == null) return node.right;
            if (node.right == null) return node.left;

            // If node has two children, replace it with the
            // minimum node in the right subtree.
            Node min = min(node.right);
            node.value = min.value;
            node.right = remove(node.right, min.value);
        }
        return node;
    }

    /**
     * Returns the minimum node in the BST rooted at node.
     */
    private Node min(Node node) {
        if (node.left == null) return node;
        return min(node.left);
    }
}
```

---

### Time Complexity

The time complexity of `contains`, `insert` and `remove` is $\Theta(H)$, where $H$ is the height of the tree. The worst case is when the tree is a linked list, which has height $n$. The best case is when the tree is balanced, which has height $\log n$.

For randomized operations, the expected time complexity is $\Theta(\log n)$.

---

**Under Construction**