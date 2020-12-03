# Circular Queue

# A circular queue is a collection of objects stored in a buffer that is treated as though it is connected end-to-end in a circle. When an object is added to this circular queue, it is added to the position that immediately follows the most recently added object, while removing an object always removes the object that has been in the queue the longest.

# This works as long as there are empty spots in the buffer. If the buffer becomes full, adding a new object to the queue requires getting rid of an existing object; with a circular queue, the object that has been in the queue the longest is discarded and replaced by the new object.

# Your task is to write a CircularQueue class that implements a circular queue for arbitrary objects. The class should obtain the buffer size with an argument provided to CircularQueue::new, and should provide the following methods:

# enqueue to add an object to the queue
# dequeue to remove (and return) the oldest object in the queue. It should return nil if the queue is empty.
# You may assume that none of the values stored in the queue are nil (however, nil may be used to designate empty spots in the buffer).


# class CircularQueue

#   attr_accessor :bfr_size, :queue_arr, :enq_index, :deq_index

#   def initialize(bfr_size)
#     @bfr_size = bfr_size
#     @queue_arr = Array.new(bfr_size, nil)
#     @enq_index = 0
#     @deq_index = nil
#   end

#   def enqueue(obj)
#     self.queue_arr[enq_index] = obj
#     if deq_index == nil
#       self.deq_index = enq_index
#     elsif enq_index == deq_index
#       self.deq_index = next_index(self.enq_index)
#     end
#     self.enq_index = next_index(self.enq_index)
#   end

#   def dequeue
#     return nil if deq_index == nil
#     ret_val = queue_arr[deq_index]
#     self.queue_arr[deq_index] = nil
#     self.deq_index = next_index(self.deq_index)
#     ret_val
#   end

#   private

#   def next_index(curr_index)
#     (curr_index + 1) % bfr_size
#   end

# end

# Further Exploration

class CircularQueue

  attr_accessor :bfr_size, :queue_arr

  def initialize(bfr_size)
    @bfr_size = bfr_size
    @queue_arr = []
  end

  def enqueue(obj)
    queue_arr.shift if queue_arr.size >= bfr_size
    queue_arr.push(obj)
  end

  def dequeue
    return nil if queue_arr.empty?
    queue_arr.shift
  end
end


queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil
