class Message < ActiveRecord::Base
  include ParserHelper
  scope :aerodrome_hours, -> { where("e_section like ?", "%AERODROME HOURS OF OPS/SERVICE%") }


  def generate lines
    message = concat_lines(lines)
    self.title_section = message.partition('Q)').first
    self.q_section = section_between_markers(message, "Q)", "A)")
    self.a_section = section_between_markers(message, "A)", "B)")
    self.b_section = section_between_markers(message, "B)", "C)")
    self.c_section = section_between_markers(message, "C)", "E)")
    self.e_section = message.partition('E)').last
  end

  def open_hours
    return parse_daily_hours(e_section.gsub(/\s+/, ""))
  end

  private

  def section_between_markers line, marker1, marker2
    line[/#{Regexp.escape(marker1)}(.*?)#{Regexp.escape(marker2)}/m, 1]
  end

  def concat_lines lines
    lines.compact.join(' ')
  end

  def parse_daily_hours message
    days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN']
    hours = {}
    days.each do |d|
      if m = exact_match(d, message) || m = left_match(d, message) || m = right_match(d, message) || m = in_range_match(d, message)
        hours[d.to_sym] = to_hour(m)
      end
      if m = two_hours_match(d, message)
        hours[d.to_sym] = to_hours(m)
      end
      if closed_match(d,message)
        hours[d.to_sym] = 'CLOSED'
      end
    end
    return hours
  end
end