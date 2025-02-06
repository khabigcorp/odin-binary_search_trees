require './lib/Node.rb'

class Tree
  def recursive_build_tree(array, left = 0, right = array.size)
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
    @root = recursive_build_tree(array)
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

  def find(value)
    node = @root
    until (node.nil? || node.data == value)
      if(value > node.data)
        node = node.right
      elsif(value < node.data)
        node = node.left
      end
    end
    node
  end

  def level_order
    queue = []
    queue.push(@root)
    until queue.size == 0
      current_node = queue[0]
      yield(current_node)
      queue.push(current_node.left) unless current_node.left.nil?
      queue.push(current_node.right) unless current_node.right.nil?
      queue.shift()
    end
    puts
  end

  def inorder(root = @root, &block)
    unless root.nil?
      inorder(root.left, &block) 
      yield(root)
      inorder(root.right, &block) 
    end
  end

  def preorder(root = @root, &block)
    unless root.nil?
      yield(root)
      preorder(root.left, &block) 
      preorder(root.right, &block) 
    end
  end

  def postorder(root = @root, &block)
    unless root.nil?
      postorder(root.left, &block) 
      postorder(root.right, &block) 
      yield(root)
    end
  end

  def height(node)
    unless node.nil?
      left_height = (node.left.nil?) ? 0 : 1 + height(node.left)
      right_height = (node.right.nil?) ? 0 : 1 + height(node.right)
      return (left_height > right_height) ? left_height : right_height
    else
      return 0
    end
  end
  
  def depth(find)
    height(@root) - height(find)
  end

  def balanced?(node = @root)
    unless node.nil?
      node_balanced = (height(node.left) - height(node.right)).abs < 2
      return node_balanced && balanced?(node.left) && balanced?(node.right)
    else
      return true
    end
  end

  def rebalance
    node_data = []
    level_order {|node| node_data.push(node.data)}
    @root = recursive_build_tree(node_data.sort)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end