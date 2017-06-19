# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require_relative 'bst_node'

class BinarySearchTree
  attr_reader :root

  def initialize
    @root = nil
  end

  def insert(value)
    new_node = BSTNode.new(value)
    if @root.nil?
      @root = new_node
    else
      BinarySearchTree.insert_subtree(@root, value)
    end
  end

  def find(value, tree_node = @root)
    if tree_node.nil?
      nil
    else
      BinarySearchTree.find_subtree(@root, value)
    end
  end

  def delete(value)
    @root = BinarySearchTree.delete_subtree(@root, value)
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    BinarySearchTree.maximum(tree_node)
  end

  def depth(tree_node = @root)
    if tree_node.nil?
      0
    elsif tree_node.left.nil? && tree_node.right.nil?
      0
    else
      [depth(tree_node.left), depth(tree_node.right)].max + 1
    end
  end

  def is_balanced?(tree_node = @root)
    return true if tree_node.nil?
    difference = (depth(tree_node.left) - depth(tree_node.right)).abs
    left = is_balanced?(tree_node.left)
    right = is_balanced?(tree_node.right)
    difference < 1 && left && right
  end

  def in_order_traversal(tree_node = @root, arr = [])
    in_order_traversal(tree_node.left, arr) if tree_node.left
    arr << tree_node.value
    in_order_traversal(tree_node.right, arr) if tree_node.right
    arr
  end

  def de_order_traversal(tree_node = @root, arr = [])
    de_order_traversal(tree_node.right, arr) if tree_node.right
    arr << tree_node
    de_order_traversal(tree_node.left, arr) if tree_node.left
    arr
  end

  private
  # optional helper methods go here:
  def self.insert_subtree(root, value)
    new_node = BSTNode.new(value)
    if root.nil?
      root = new_node
    elsif root.value >= value
      root.left = BinarySearchTree.insert_subtree(root.left, value)
    else
      root.right = BinarySearchTree.insert_subtree(root.right, value)
    end
    root
  end

  def self.find_subtree(root, value)
    if root.nil?
      nil
    elsif root.value == value
      root
    elsif root.value > value
      BinarySearchTree.find_subtree(root.left, value)
    else
      BinarySearchTree.find_subtree(root.right, value)
    end
  end

  def self.delete_subtree(root, value)
    if root.nil?
      nil
    elsif root.value > value
      root.left = BinarySearchTree.delete_subtree(root.left, value)
    elsif root.value < value
      root.right = BinarySearchTree.delete_subtree(root.right, value)
    else
      if root.left.nil? && root.right.nil?
        nil
      elsif !root.left.nil? && !root.right.nil?
        max_from_left = BinarySearchTree.maximum(root.left)
        if max_from_left.left.nil?
          max_from_left
        else
          temp = max_from_left
          temp = temp.left
          max_from_left.left = root.left
          max_from_left.right = root.right
          max_from_left
        end
      else
        root.left.nil? ? root.right : root.left
      end
    end
  end

  def self.maximum(root)
    if root.right.nil?
      root
    else
      BinarySearchTree.maximum(root.right)
    end
  end

end
