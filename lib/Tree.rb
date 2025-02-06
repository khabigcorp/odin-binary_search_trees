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

  def delete(value)
    child = @root
    parent = child
    left_child = false
    until (child.nil? || child.data == value)
      if(value > child.data)
        parent = child
        child = child.right
        left_child = false
      elsif(value < child.data)
        parent = child
        child = child.left
        left_child = true
      end
    end

    return nil if child.nil?
    until (child.right.nil? && child.left.nil?)
      if (!child.left.nil?)
        child.data, child.left.data = child.left.data, child.data
        parent = child
        child = child.left
        left_child = true
      elsif (!child.right.nil?)
        child.data, child.right.data = child.right.data, child.data
        parent = child
        child = child.right
        left_child = false
      end
    end
    
    if(left_child)
      parent.left = nil
    else
      parent.right = nil
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end