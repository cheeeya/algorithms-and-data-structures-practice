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
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
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
      else
        insert_node(value, node.left)
      end
    when -1
      if node.right.nil?
        node.right = BSTNode.new(value)
      else
        insert_node(value, node.right)
      end
    end
  end

end
