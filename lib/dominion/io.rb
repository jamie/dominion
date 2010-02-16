class Dominion::AbstractIO
  def initialize
    raise 'Use a subclass instead!'
  end

  def gets(*args)
    out = (@reader.gets(*args) || "").chomp
    raise IOError if out == "^D"
    out
  end
  
  def print(*args)
    @writer.print(*args)
  end
  
  def puts(*args)
    @writer.puts(*args)
    @writer.puts("\n")
  end
  
end

class Dominion::BufferIO < Dominion::AbstractIO
  attr_reader :reader, :writer
  def initialize
    @reader = StringIO.new
    @writer = StringIO.new
  end
end

class Dominion::StandardIO < Dominion::AbstractIO
  def initialize
    @reader = STDIN
    @writer = STDOUT
  end
end
