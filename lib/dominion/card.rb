class Dominion::Card
  def self.named(name)
    @cards[name]
  end

  def self.kingdom
    @cards.values.reject{|e|e.base?}.map{|e|e.name}
  end

  def self.define(name, &block)
    @cards ||= {}
    if block_given?
      @cards[name] = self.new(name)
      @cards[name].instance_eval &block
    end
    @cards[name]
  end

  def self.define_base(name, cost, *types, &block)
    card = define(name, &block)
    card.base true
    card.cost cost
    card.type types
  end

  def self.define_kingdom(name, cost, *types, &block)
    card = define(name, &block)
    card.cost cost
    card.type types
  end

  def initialize(name)
    self.name name
  end

  def kingdom(cost, set, *types)
    self.set set
    self.cost cost
    self.type types
  end
  
  # Deprecated, but not gone
  def type(*args)
    method_missing(:type, *args)
  end
  
  def method_missing(method, *args, &block)
    @meta ||= {}
    
    case method.to_s
    when /_for$/
      m = method.to_s.chomp('_for').to_sym
      @meta[m].call(*args)
    when /\?$/
      m = method.to_s.chomp('?').to_sym
      @meta[m]
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
      def #{type.downcase}?
        @meta[:set] == "#{type}" or @meta[:type].include? "#{type}"
      end
    EVAL
  end
end
