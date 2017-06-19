require_relative 'binary_search_tree'

def kth_largest(tree_node, k)
  bst = BinarySearchTree.new
  desc = bst.de_order_traversal(tree_node)
  desc[k -1]
end
