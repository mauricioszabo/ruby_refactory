require 'ruby_refactory/and_or'

describe RubyRefactory::AndOr do
  it 'should refactor "ors"' do
    rf = RubyRefactory::AndOr.new('(a == b) || (x == y)')
    rf.refactored.should == 
      "condition_1 = (a == b)\n" +
      "condition_2 = (x == y)\n" +
      "condition_1 or condition_2"
  end

  it 'should refactor multiple "ors"' do
    rf = RubyRefactory::AndOr.new('(a == b) || (x == y) || (x == h) || (p == y)')
    rf.refactored.should == 
      "condition_1 = (a == b)\n" +
      "condition_2 = (x == y)\n" +
      "condition_3 = (x == h)\n" +
      "condition_4 = (p == y)\n" +
      "condition_1 or condition_2 or condition_3 or condition_4"
  end

  it 'should refactor "ands"' do
    rf = RubyRefactory::AndOr.new('(a == b) && (x == y)')
    rf.refactored.should == 
      "condition_1 = (a == b)\n" +
      "condition_2 = (x == y)\n" +
      "condition_1 and condition_2"
  end

  it 'should refactor nested "ands"' do
    rf = RubyRefactory::AndOr.new('(a == b) && (x == y) && (c == d)')
    rf.refactored.should == 
      "condition_1 = (a == b)\n" +
      "condition_2 = (x == y)\n" +
      "condition_3 = (c == d)\n" +
      "condition_1 and condition_2 and condition_3"
  end

  it 'should understand that "ors" inside conditions are not to be refactored' do
    rf = RubyRefactory::AndOr.new('(a == b) && (c || d)')
    rf.refactored.should == 
      "condition_1 = (a == b)\n" +
      "condition_2 = c\n" +
      "condition_3 = d\n" +
      "condition_1 and condition_2 or condition_3"
  end

  it 'should parse correctly an "and" with higher precedence' do
    rf = RubyRefactory::AndOr.new('(a == b) && c || d')
    rf.refactored.should == 
      "condition_1 = ((a == b) and c)\n" +
      "condition_2 = d\n" +
      "condition_1 or condition_2"
  end
end
