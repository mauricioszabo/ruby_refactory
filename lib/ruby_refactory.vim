ruby require 'ruby_refactory/and_or.rb'

function! RefactorEverything()
    ruby <<RUBY
        work_on = VIM.evaluate('getreg()')
        refactory = RubyRefactory::AndOr.new(work_on)
        before = refactory.before.gsub "'", "''"
        substitute = refactory.substitute.gsub "'", "''"

        #VIM.command("let before='#{before}'")
        VIM.command("call setreg('b', '#{before}')")
        VIM.command("call setreg('a', '#{substitute}')")

        #substitute = @refactory.substitute
        
        #buffer.line = substitute
        #start = buffer.line_number - 1
        #before.each_line.with_index do |line, index|
        #    buffer.append start + index, line.strip
        #end
        #buffer.delete buffer.line_number+1
        #buffer.append buffer.line_number+1, substitute
RUBY
endfunction

":call InstantiateRubyRefactory()
map ref d:call RefactorEverything()<CR>"aPO<ESC>"bP
