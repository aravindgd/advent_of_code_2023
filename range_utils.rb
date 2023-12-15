module RangeUtils
  refine Range.singleton_class do
    def build_from_size(range_start, size)
      return nil if size.zero? || size.negative? || size.nil?
      return nil if range_start.nil?

      range_end = range_start + (size - 1)

      new(range_start, range_end)
    end
  end

  refine Range do
    # activesupport/lib/active_support/core_ext/range/overlaps.rb
    def overlaps?(other)
      other.begin == self.begin || cover?(other.begin) || other.cover?(self.begin)
    end
  end
end
