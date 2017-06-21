class DynamicProgramming
  def initialize
    @blair_cache = {1 => 1, 2 => 2}
  end

  def blair_nums(n)
    return @blair_cache[n] unless @blair_cache[n].nil?
    ans = blair_nums(n - 1) + blair_nums(n - 2) + 2 * n -1
    @blair_cache[n] = ans
    ans
  end

  def frog_hops(n)
    cache = frog_cache_builder(n)
    cache[n]
  end

  def frog_cache_builder(n)
    cache = {1 => [[1]], 2 => [[1, 1], [2]],
            3 => [[1, 1, 1], [1, 2], [2, 1], [3]]}
    return cache if n < 4
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
      # cache[i] = cache[i - 1] + cache [i - 2] + cache [i - 3]
    end
    cache
  end

  def frog_hops_top_down(n)
  end

  def super_frog_hops(n, k)
  end

  def make_change(amt, coins)
  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
