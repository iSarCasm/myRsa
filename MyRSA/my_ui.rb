module MyUI
  def self.progress(str, all, current)
    progress = (current.to_f / all * 100).floor
    $stdout.flush
    print "#{str}.. [ #{progress}% ]\r"
  end
end
