require './lib/Tree.rb'

new_array = (Array.new(15) { rand(1..100) })
tree = Tree.new
tree.build_tree(new_array)
puts tree.balanced?
tree.preorder {|node| print "#{node.data} "}
puts
tree.postorder {|node| print "#{node.data} "}
puts
tree.inorder {|node| print "#{node.data} "}
puts
tree.insert(150)
tree.insert(200)
tree.insert(2391)
puts tree.balanced?
tree.rebalance
puts tree.balanced?
tree.preorder {|node| print "#{node.data} "}
puts
tree.postorder {|node| print "#{node.data} "}
puts
tree.inorder {|node| print "#{node.data} "}
puts
tree.pretty_print