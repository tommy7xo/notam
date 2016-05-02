class Message < ActiveRecord::Base

  scope :aerodrome_hours, -> { where("e_section like ?", "%AERODROME HOURS OF OPS/SERVICE%") }

  def generate lines
    self.title_section = lines[0]
    self.q_section = lines[1]
    self.a_section = section_between_markers(lines[2], "A)", "B)")
    self.b_section = section_between_markers(lines[2], "B)", "C)")
    self.c_section = lines[2].partition('C)').last
    self.e_section = concat_lines(lines[3], lines[4], lines[5], lines[6])
  end

  private

  def section_between_markers line, marker1, marker2
    line[/#{Regexp.escape(marker1)}(.*?)#{Regexp.escape(marker2)}/m, 1]
  end

  def concat_lines *lines
    lines.compact.join
  end
end