module ArrayUtils
  refine Array do
    def split_at_value(value)
      arr = dup
      result = []

      while (index = arr.index(value))
        result << arr.shift(index)
        arr.shift
      end

      result << arr
    end
  end
end
