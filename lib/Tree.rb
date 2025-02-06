require './lib/Node.rb'

class Tree
  def recursive_build_tree(array, left, right)
    if (left < right - 1)
      middle = (left+right)/2
      root = Node.new(array[middle])
      root.left = recursive_build_tree(array, left, middle)
      root.right = recursive_build_tree(array, middle, right)
      return root
    else
      return nil
    end
  end

  def build_tree(array)
    array.sort!
    @root = recursive_build_tree(array, 0, array.size)
  end

  def insert(value)
    root = @root
    loop do
      if (value > root.data)
        if (root.right.nil?)
          root.right = Node.new(value)
          return nil
        else
          root = root.right
        end
      elsif (value < root.data)
        if (root.left.nil?)
          root.left = Node.new(value)
          return nil
        else
          root = root.left
        end
      end
    end
  end
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end