require_relative 'heap'
# Let's use our BinaryMinHeap to solve a whiteboarding-style question.
# Given an `array` and an integer `k`,
# return the k-largest elements in `O(k + (n-k)logk)` time.


# `O(klogk + (n-k)klogk)` ?
def k_largest_elements(array, k)
  # k_elements = array[0...k]
  k_elements = BinaryMinHeap.heapify_down(array[0...k], 0, k)
  array[k..-1].each do |ele|
    if ele > k_elements[0]
      k_elements[0] = ele
      k_elements = BinaryMinHeap.heapify_down(k_elements, 0, k)
    end
  end
  k_elements
end


# `O(klogk + (n-k)logk)`
def k_largest_elements2(array, k)
  result = BinaryMinHeap.new
  k.times do
    result.push(array.pop)
  end
  until array.empty?
    result.push(array.pop)
    result.extract
  end
  result.store
end
