require 'byebug'

class DynamicProgramming
  def initialize
    @blair_cache = {1 => 1, 2 => 2}
    @frog_cache = {
                    0 => [[]],
                    1 => [[1]],
                    2 => [[1, 1], [2]],
                    3 => [[1, 1, 1], [1, 2], [2, 1], [3]]
                  }
    @super_frog_cache = {
                          1 => {
                                  0 => [[]],
                                  1 => [[1]]
                                }
                        }
    @maze_cache = {}
  end

  def blair_nums(n)
    return @blair_cache[n] unless @blair_cache[n].nil?
    ans = blair_nums(n - 1) + blair_nums(n - 2) + 2 * n - 1
    @blair_cache[n] = ans
    ans
  end

  def frog_hops(n)
    cache = frog_cache_builder(n)
    cache[n]
  end

  def frog_cache_builder(n)
    cache = {
              0 => [[]],
              1 => [[1]],
              2 => [[1, 1], [2]],
              3 => [[1, 1, 1], [1, 2], [2, 1], [3]]
            }
    return cache if n < 4
    return cache if n > 11
    (4..n).each do |i|
      step1 = cache[i - 1].map do |ele|
        ele + [1]
      end
      step2 = cache[i - 2].map do |ele|
        ele + [2]
      end
      step3 = cache[i - 3].map do |ele|
        ele + [3]
      end
      cache[i] = step1 + step2 + step3
    end
    cache
  end

  def frog_hops_top_down(n)
    return @frog_cache[n] unless @frog_cache[n].nil?
    ans = frog_hops_top_down(n - 1).map {|e| el + [1] }
          + frog_hops_top_down(n - 2).map {|e| el + [2] }
          + frog_hops_top_down(n - 3).map {|e| el + [3] }
    @frog_cache[n] = ans
    ans
  end

  def super_frog_hops(n, k)
    if @super_frog_cache[k].nil?
      @super_frog_cache[k] = {
                              0 => [[]],
                              1 => [[1]]
                            }
    end
    return @super_frog_cache[k][n] unless @super_frog_cache[k][n].nil?
    ans = []
    k = n < k ? n : k
    (1..k).each do |idx|
      ans += super_frog_hops(n - idx, k).map { |el| el + [idx] }
    end
    @super_frog_cache[k][n] = ans
    ans
  end

  def make_change(amt, coins)
    return [] if amt == 0
    return nil if coins.none? { |coin| coin <= amt }

    coins = coins.sort.reverse

    best_change = nil
    coins.each_with_index do |coin, index|
      next if coin > amt
      remainder = amt - coin

      best_remainder = make_change(remainder, coins.drop(index))
      next if best_remainder.nil?

      this_change = [coin] + best_remainder
      if (best_change.nil? || (this_change.count < best_change.count))
        best_change = this_change
      end
    end

    best_change = best_change ? best_change.sort : nil
  end

  def maze_solver(maze, start_pos, end_pos)
    populate_maze_cache(maze)
    solve_maze(maze, start_pos, end_pos)
    p @maze_cache
    @maze_cache[end_pos[0]][end_pos[1]]
  end

  private

  def populate_maze_cache(maze)
    maze.each_with_index do |column, i|
      @maze_cache[i] = {}
      column.each_with_index do |row, j|
        if row == ' ' || row == 'F'
          @maze_cache[i][j] = []
        elsif row == 'S'
          @maze_cache[i][j] = [[i, j]]
        end
      end
    end
  end

  def solve_maze(maze, start_pos, finish_pos)
    return nil unless @maze_cache[start_pos[0]][start_pos[1]]
    return nil if start_pos[0] < 0 || start_pos[1] >= maze.length
    return nil if start_pos[1] < 0 || start_pos[1] >= maze[0].length
    # return @maze_cache unless @maze_cache[finish_pos[0]][finish_pos[1]].empty?
    if @maze_cache[start_pos[0]][start_pos[1]].empty?
      @maze_cache[start_pos[0]][start_pos[1]] = [start_pos]
      return [start_pos]
    end
    @maze_cache.each do |keyi, column|
      column.each do |keyj, row|
        @maze_cache[keyi+1][keyj] += [start_pos] + [keyi+1, keyj] if solve_maze(maze, [keyi+1, keyj], finish_pos)
        @maze_cache[keyi][keyj+1] += [start_pos] + [keyi, keyj+1] if solve_maze(maze, [keyi, keyj+1], finish_pos)
        @maze_cache[keyi-1][keyj] += [start_pos] + [keyi-1, keyj] if solve_maze(maze, [keyi-1, keyj], finish_pos)
        @maze_cache[keyi][keyj-1] += [start_pos] + [keyi, keyj-1] if solve_maze(maze, [keyi, keyj-1], finish_pos)
      end
    end
    @maze_cache
  end
end
