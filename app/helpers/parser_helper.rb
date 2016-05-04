module ParserHelper
  def to_hour(line)
    line.to_s.gsub!(/\D/, '').insert(4, '-')
  end

  def to_hours(line)
    line.to_s.gsub!(/\D/, '').insert(12, '-').insert(8, "\n").insert(4, '-')
  end

  def exact_match(word, message)
    /#{word}\d{4}-\d{4}/.match(message)
  end

  def left_match(word, message)
    /#{word}-\w{3}\d{4}-\d{4}/.match(message)
  end

  def right_match(word, message)
    /\w{3}-#{word}\d{4}-\d{4}/.match(message)
  end

  def in_range_match word, message
    if /#{word}/.match(message).nil?
      /\w{3}-\w{3}\d{4}-\d{4}/.match(message)
    end
  end

  def two_hours_match(word, message)
    /#{word}\d{4}-\d{4},\d{4}-\d{4}/.match(message)
  end

  def closed_match word, message
    /#{word}CLOSED/.match(message) || /#{word}CLSD/.match(message)
  end
end
