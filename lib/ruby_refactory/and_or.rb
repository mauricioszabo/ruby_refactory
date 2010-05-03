require 'ruby_refactory/base'

module RubyRefactory
  class AndOr < RubyRefactory::Base
    OPERATIONS = [:or, :and]

    attr_reader :before, :substitute

    def initialize(source)
      @conditions = []
      super
      create_refactored_strings
    end

    def process_or(sexp)
      operand = sexp.shift
      first_argument = sexp.shift
      second_argument = sexp.shift
      add_to_conditions(first_argument, operand)
      add_or_process(second_argument)
      sexp
    end
    alias :process_and :process_or

    def to_ruby(sexp)
      @ruby2ruby.process sexp.to_a
    end

    private
    def create_refactored_strings
      conditions_string = ''
      output = ''
      @conditions.each_slice(2).with_index do |(condition, operand), index|
        index += 1
        conditions_string << "condition_#{index} = #{condition}\n"
        output << "condition_#{index} #{operand} "
      end

      @before = conditions_string.strip
      @substitute = output.strip
    end

    def add_to_conditions(sexp, operand = nil)
      @conditions << to_ruby(sexp)
      @conditions << operand
    end

    def add_or_process(argument)
      argument_is_boolean_operator = OPERATIONS.include?(argument[0])
      if(argument_is_boolean_operator)
        process(argument)
      else
        add_to_conditions(argument)
      end
    end
  end
end
