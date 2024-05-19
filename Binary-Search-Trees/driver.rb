require_relative 'binary_search_trees'

test_array = Array.new(15){rand(1..100)}
test_tree = Tree.new(test_array)
test_tree.pretty_print
print("Balance Status: ", test_tree.balanced?, "\n")
print("Inorder-traversal: ", test_tree.inorder_traversal, "\n")
print("Preorder-traversal: #{test_tree.preorder_traversal} \n")
print("Postorder-traversal: #{test_tree.postorder_traversal} \n")
print("Levelorder-traversal: #{test_tree.levelorder_traversal} \n")

unbalancer = Array.new(5) {rand(101..200)}
unbalancer.each{|element| test_tree.insert(element)}
test_tree.pretty_print
print("Balance Status: ", test_tree.balanced?, "\n")
test_tree.rebalance
test_tree.pretty_print
print("Balance Status: ", test_tree.balanced?, "\n")
print("Inorder-traversal: ", test_tree.inorder_traversal, "\n")
print("Preorder-traversal: #{test_tree.preorder_traversal} \n")
print("Postorder-traversal: #{test_tree.postorder_traversal} \n")
print("Levelorder-traversal: #{test_tree.levelorder_traversal} \n")
