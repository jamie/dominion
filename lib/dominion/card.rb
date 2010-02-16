class Dominion::Card
  include Comparable

  def self.[](name)
    @cards[name]
  end

  def self.kingdom
    @cards.values.reject{|e|e.base?}.sort.map{|e|e.name}
  end

  def self.define(name, &block)
    @cards ||= {}
    card = self.new(name)
    if block_given?
      card.instance_eval &block
      @cards[name] = card
    end
    card
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

  def <=>(other)
    order = [:action?, :treasure?, :victory?, :curse?]
    order.each do |m|
      case [self.send(m), other.send(m)]
      when [true, false]; return -1
      when [false, true]; return 1
      end
    end
    r = self.cost <=> other.cost
    return r unless r.zero?
    self.name <=> other.name
  end

  def call(game)
    action.call(game) if action
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
