class FileUpload
  def initialize file
    @file = file
    @message = Array.new
  end

  def valid?
    !@file.nil? && txt?
  end

  def create_messages
    File.open(@file.path, 'r') do |f|
      f.each do |line|
        line == "\n" ? close_message : add_line_to_message(line)
      end
    end
  end

  private

  def txt?
    @file.content_type == 'text/plain'
  end

  def close_message
    message = Message.new
    message.generate(@message)
    message.save
    @message = Array.new
  end

  def add_line_to_message line
    @message << line
  end
end