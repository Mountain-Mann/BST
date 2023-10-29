# frozen_string_literal: true

require 'pry'

# Node creation
class Node
  include Comparable
  attr_accessor :value, :left, :right, :height

  def initialize(value = nil)
    @value = value
    @left = nil
    @right = nil
    @height = 0
  end

  def insert(value)
    if value == @value
      self
    elsif value < @value
      if @left.nil?
        @left = Node.new(value)
      else
        @left.insert(value)
      end
    else
      if @right.nil?
        @right = Node.new(value)
      else
        @right.insert(value)
      end
    end
  end
end

# Tree creation
class Tree
  attr_accessor :root

  def initialize(arr)
    @root = build_tree(arr.sort.uniq)
  end

  def build_tree(arr)
    return nil if arr.empty?

    middle = arr.length / 2
    root = Node.new(arr[middle])
    root.left = build_tree(arr[0...middle])
    root.right = build_tree(arr[middle + 1..])
    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value)
    if @root.nil?
      @root = Node.new(value)
    else
      @root.insert(value)
    end
  end

def delete_node(value, node = @root)
  # Base case: node not found
  return node if node.nil?

  if value < node.value
    node.left = delete_node(value, node.left)
  elsif value > node.value
    node.right = delete_node(value, node.right)
  else
    # Node with only left child
    if node.left.nil?
      return node.right
    # Node with only right child
    elsif node.right.nil?
      return node.left
    end

    # Node with two children
    replacement_node = minimum_node(node.right)
    node.value = replacement_node.value
    node.right = delete_node(replacement_node.value, node.right)
  end

  node
end

  def find(value, node = @root)
    return puts nil if node.nil?
    return puts node if node.value == value

    if value < node.value
      find(value, node.left)
    else
      find(value, node.right)
    end
  end

  def level_order(&block)
    return enum_for(:level_order) unless block_given?

    queue = [@root]
    values = []

    until queue.empty?
      node = queue.shift
      values << node.value
      queue.concat([node.left, node.right])
    end

    yield values
  end

  def inorder(&block)
    return enum_for(:inorder) unless block_given?

    inorder_traversal(@root, &block)
  end

  def preorder(&block)
    return enum_for(:preorder) unless block_given?

    preorder_traversal(@root, &block)
  end

  def postorder(&block)
    return enum_for(:postorder) unless block_given?

    postorder_traversal(@root, &block)
  end

  # Calculates the height of a binary tree node.

  def height(node)
    return 0 if node.nil?

    [height(node.left), height(node.right)].max + 1
  end

  # Calculates the depth of a given node in a binary tree.

  def depth(node, current_depth = 0)
    return current_depth if node.nil?

    [depth(node.left, current_depth + 1), depth(node.right, current_depth + 1)].max
  end

  def balanced?(node = @root)
    return true if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)

    return false if (left_height - right_height).abs > 1

    balanced?(node.left) && balanced?(node.right)
  end

  def rebalance(node = @root)
    array = in_order_traversal(node)
    @root = build_tree(array)
  end

  def in_order_traversal(node = @root)
    return [] if node.nil?

    left_array = in_order_traversal(node.left)
    right_array = in_order_traversal(node.right)
    left_array + [node.value] + right_array
  end

  def preorder_traversal(node = @root)
    return [] if node.nil?

    left_array = preorder_traversal(node.left)
    right_array = preorder_traversal(node.right)
    [node.value] + left_array + right_array
  end

  def postorder_traversal(node = @root)
    return [] if node.nil?

    left_array = postorder_traversal(node.left)
    right_array = postorder_traversal(node.right)
    left_array + right_array + [node.value]
  end

  def level_order_traversal(node = @root)
    return [] if node.nil?

    queue = [node]
    result = []

    until queue.empty?
      node = queue.shift
      result << node.value if node
      queue.concat([node.left, node.right]) if node
    end

    result
  end
  
  private

  def minimum_node(node)
    current_node = node

    current_node = current_node.left until current_node.left.nil?

    current_node
  end
end

# Create a binary search tree from an array of random numbers
array = Array.new(15) { rand(1..100) }
tree = Tree.new(array)
tree.pretty_print

# Confirm that the tree is balanced
puts "Is the tree balanced? #{tree.balanced?}"

# Print out all elements in level, pre, post, and in order
puts 'Level order traversal:'
p tree.level_order_traversal

puts 'Pre order traversal:'
p tree.preorder_traversal

puts 'Post order traversal:'
p tree.postorder_traversal

puts 'In order traversal:'
p tree.in_order_traversal

# Unbalance the tree by adding several numbers > 100
tree.insert(101)
tree.insert(102)
tree.insert(103)

# Confirm that the tree is unbalanced
puts "\nIs the tree balanced? #{tree.balanced?}"
tree.pretty_print

# Balance the tree
tree.rebalance
puts 'Rebalancing the tree...'
tree.pretty_print

# Confirm that the tree is balanced
puts "Is the tree balanced? #{tree.balanced?}"

# Print out all elements in level, pre, post, and in order

puts 'Level order traversal:'
p tree.level_order_traversal

puts 'Pre order traversal:'
p tree.preorder_traversal

puts 'Post order traversal:'
p tree.postorder_traversal

puts 'In order traversal:'
p tree.in_order_traversal
