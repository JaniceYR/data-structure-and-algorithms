require 'byebug'

class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @prc = prc
    @store = Array.new
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    first = @store.pop
    @store = BinaryMinHeap.heapify_down(@store, 0, count, &@prc)
    first
  end

  def peek
    @store.first
  end

  def push(val)
    @store.push(val)
    @store = BinaryMinHeap.heapify_up(@store, @store.length-1, &@prc)
  end

  public
  def self.child_indices(len, parent_index)
    children = []
    child1 = (parent_index * 2) + 1
    child2 = (parent_index * 2) + 2
    children << child1 if child1 < len
    children << child2 if child2 < len
    children
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index.zero?
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| (el1 <=> el2) }
    until BinaryMinHeap.child_indices(len, parent_idx).empty?
      children = BinaryMinHeap.child_indices(len, parent_idx)
      # byebug
      if (children.length == 1 || prc.call(array[children[0]], array[children[1]]) < 0) &&
        (prc.call(array[children[0]], array[parent_idx]) < 0)
        array[parent_idx], array[children[0]] = array[children[0]], array[parent_idx]
        parent_idx = children[0]
      elsif (children.length == 2) && prc.call(array[children[1]], array[parent_idx]) < 0
        array[parent_idx], array[children[1]] = array[children[1]], array[parent_idx]
        parent_idx = children[1]
      else
        return array
      end
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| (el1 <=> el2) }
    while child_idx >= 1
      parent_idx = BinaryMinHeap.parent_index(child_idx)
      if prc.call(array[child_idx], array[parent_idx]) < 0
        array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      end
      child_idx -= 1
    end
    array
  end
end
