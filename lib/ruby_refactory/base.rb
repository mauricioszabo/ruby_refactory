require 'rubygems'
require 'ruby_parser'
require 'ruby2ruby'
require 'sexp_processor'

module RubyRefactory
  class Base < SexpProcessor
    def initialize(code)
      super()
      @ruby2ruby = Ruby2Ruby.new
      sexp = RubyParser.new.parse(code)
      process(sexp)
    end

    def refactored
      "#{before}\n#{substitute}"
    end
  end
end
