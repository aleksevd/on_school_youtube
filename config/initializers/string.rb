class String
  def unicode_downcase
    mb_chars.downcase.to_s
  end

  def unicode_upcase
    mb_chars.upcase.to_s
  end

  def unicode_capitalize
    string = self
    string[0].try(:mb_chars).try(:capitalize).to_s
  end

  def unicode_capitalize!
    self[0] = self[0].mb_chars.capitalize.to_s
    self
  end
end
