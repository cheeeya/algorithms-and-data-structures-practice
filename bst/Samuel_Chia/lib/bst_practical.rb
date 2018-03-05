
def kth_largest(tree_node, k)
  result = reverse_traverse(tree_node, [])
  result[k - 1]
end

def reverse_traverse(node, arr)
  reverse_traverse(node.right, arr) if node.right
  arr << node
  reverse_traverse(node.left, arr) if node.left
  arr
end
