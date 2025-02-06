require './lib/Tree.rb'

new_array = Array.new(15) { rand(1..100) }
new_tree = Tree.new
new_tree.build_tree(new_array)
new_tree.pretty_print
new_tree.insert(1)
new_tree.insert(2)
new_tree.insert(3)
new_tree.insert(4)
new_tree.pretty_print