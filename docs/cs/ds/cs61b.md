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

**Under Construction**