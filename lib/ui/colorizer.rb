class Colorizer
  def colorize(color_code, string)
    "\e[#{color_code}m#{string}\e[0m"
  end

  def dim(string)
    "\e[2m#{string}\e[22m"
  end

  def green(string)
    colorize(32, string)
  end

  def magenta(string)
    colorize(35, string)
  end

  def blue(string)
    colorize(34, string)
  end

  def yellow(string)
    colorize(33, string)
  end
end
