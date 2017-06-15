require_relative "heap"

class Array
  def heap_sort!
    (0...self.length).each do |start|
      BinaryMinHeap.heapify_up(self, self.length - 1 - start, self.length - start)
      self[0], self[self.length - 1 - start] = self[self.length - 1 - start], self[0]
    end
    reverse!

    # BinaryMinHeap.heapify_up(self, self.length - 1, self.length)
    # self[0], self[-1] = self[-1], self[0]
    # (0...self.length).each do |start|
    #   BinaryMinHeap.heapify_down(self, 0, self.length - start)
    #   self[0], self[self.length - start] = self[self.length - start], self[0]
    # end
  end
end
