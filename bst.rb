# # frozen_string_literal: true

# # Create Node class
# class Node
#   attr_accessor :data, :left, :right

#   def initialize(data)
#     @data = data
#     @left = nil
#     @right = nil
#   end
# end

# # Create Tree class
# class Tree
#   attr_accessor :root, :data

#   def initialize(array)
#     @data = array.sort.uniq
#     @root = build_tree(data)
#   end

#   def build_tree(array)
#     # takes sorted array and turns it into tree
#     return puts false if array.empty?

#     p @data
#     mid = (array.length - 1) / 2.0
#     root_node = Node.new(@data[mid.floor])
#     puts root_node.data
#     root_node.left = Node.new(@data[mid - mid.floor])
#     puts root_node.left.data
#     puts root_node.right
#     # return value should be level zero root node
#   end

#   def pretty_print(node = @root, prefix = '', is_left: true)
#     pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
#     puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
#     pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
#   end
# end

# arr = [1, 2, 3, 4, 5, 6, 7]
# arr2 = [4, 3, 6, 1, 7, 9]
# bst = Tree.new(arr)
# bst.pretty_print

# Node creation
class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data = nil)
    @data = data
    @left = nil
    @right = nil
  end

  def insert(value)
    if value == @data
      self
    elsif value < @data
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

  def <=>(other)
    @data <=> other.data
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
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value)
    if @root.nil?
      @root = Node.new(value)
    else
      @root.insert(value)
    end
  end
end

# Example usage of Tree class
arr = [5, 2, 7, 1, 4, 6, 8, 3]
tree = Tree.new(arr)
tree.pretty_print

tree.insert(9)
tree.pretty_print

tree.insert(0)
tree.pretty_print
