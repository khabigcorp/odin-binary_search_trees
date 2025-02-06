require './lib/Tree.rb'

new_array = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
new_tree = Tree.new
new_tree.build_tree(new_array)
new_tree.pretty_print
new_tree.insert(0)
new_tree.insert(-1)
new_tree.insert(-2)
new_tree.insert(-3)
new_tree.pretty_print

new_tree.delete(8)
new_tree.pretty_print

found_node = new_tree.find(4)
puts found_node.left.data
puts found_node.right.data

new_tree.level_order {|node| print "#{node.data} "}
puts
new_tree.inorder {|node| print "#{node.data} "}
puts
new_tree.preorder {|node| print "#{node.data} "}
puts
new_tree.postorder {|node| print "#{node.data} "}
puts

puts "Height"
puts new_tree.height(new_tree.find(4))