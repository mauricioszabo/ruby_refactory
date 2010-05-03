require 'ruby_refactory/base'

describe RubyRefactory::Base do
  before do
    @base = RubyRefactory::Base.new("def foo; end")
  end

  it 'should return a "refactored" version concatenating two other methods' do
    @base.should_receive("before").and_return("Running this before")
    @base.should_receive("substitute").and_return("After")
    @base.refactored.should == "Running this before\nAfter"
  end
end
