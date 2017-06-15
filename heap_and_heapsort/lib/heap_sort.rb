require_relative "heap"

class Array
  def heap_sort!
    2.upto(length).each do |start|
      BinaryMinHeap.heapify_up(self, start - 1, start)
    end
    length.downto(2).each do |start|
      self[start - 1], self[0] = self[0], self[start - 1]
      BinaryMinHeap.heapify_down(self, 0, start - 1)
    end
    self.reverse!
  end
end
