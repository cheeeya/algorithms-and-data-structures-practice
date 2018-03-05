# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require 'bst_node'

class BinarySearchTree
  attr_reader :root
  def initialize
    @root = nil
  end

  def insert(value)
    return @root = BSTNode.new(value) if @root.nil?
    insert_node(value, @root)
  end

  def find(value, tree_node = @root)
    return nil if tree_node.nil?
    case tree_node.value <=> value
    when 0
      tree_node
    when 1
      find(value, tree_node.left)
    when -1
      find(value, tree_node.right)
    end
  end

  def delete(value)
    node = find(value)
    return nil if node.nil?
    return @root = nil if @root == node
    if node.left.nil? || node.right.nil?
      delete_node(node)
    else
      max = maximum(node.left)
      delete_node(max)
      max.left = node.left
      max.right = node.right
      node.left.parent = max
      node.right.parent = max
      delete_node(node, max)
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    return tree_node if tree_node.right.nil?
    maximum(tree_node.right)
  end

  def depth(tree_node = @root)
  end

  def is_balanced?(tree_node = @root)
  end

  def in_order_traversal(tree_node = @root, arr = [])
  end


  private
  # optional helper methods go here:
  def insert_node(value, node)
    case node.value <=> value
    when 1
      if node.left.nil?
        node.left = BSTNode.new(value)
        node.left.parent = node
      else
        insert_node(value, node.left)
      end
    when -1
      if node.right.nil?
        node.right = BSTNode.new(value)
        node.right.parent = node
      else
        insert_node(value, node.right)
      end
    end
  end

  def delete_node(node, child = nil)
    child ||= promote_child(node)
    child.parent = node.parent if child
    case node.parent.value <=> node.value
    when -1
      node.parent.right = child
    when 1
      node.parent.left = child
    end
  end

  def promote_child(node)
    return node.left if node.left
    return node.right if node.right
    nil
  end

end
