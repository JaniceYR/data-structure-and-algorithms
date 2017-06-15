require_relative 'heap'
# Let's use our BinaryMinHeap to solve a whiteboarding-style question.
# Given an `array` and an integer `k`,
# return the k-largest elements in `O(k + (n-k)logk)` time.

def k_largest_elements(array, k)
  k_elements = BinaryMinHeap.heapify_down(array[0...k], 0, k)
  array[k..-1].each do |ele|
    if ele > k_elements[0]
      k_elements[0] = ele
      k_elements = BinaryMinHeap.heapify_down(k_elements, 0, k)
    end
  end
  k_elements
end
