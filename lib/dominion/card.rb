class Dominion::Card
  def self.all
    []
  end
  
  # Deprecated, but not gone
  def self.type(*args)
    method_missing(:type, *args)
  end
  
  def self.method_missing(method, *args, &block)
    @meta ||= {}
    
    case method.to_s
    when /_for$/
      m = method.to_s.chomp('_for').to_sym
      @meta[m].call(*args)
    else
      if block_given?
        @meta[method] = block.to_proc
      elsif args.size > 0
        @meta[method] = args.first
      else
        @meta[method]
      end
    end
  end
  
  %w(Victory Treasure Curse Action Attack Reaction Duration).each do |type|
    eval <<-EVAL
      def self.#{type.downcase}?
        case @meta[:type]
        when String
          @meta[:type] == "#{type}"
        when Array
          @meta[:type].include? "#{type}"
        end
      end
    EVAL
  end
end
