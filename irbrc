#!/usr/bin/ruby

IRB_START_TIME = Time.now
print "Loading... "
ARGV.concat [ "--readline", "--prompt-mode", "simple" ]

#begin 
#    require 'minigems'
#rescue LoadError => e
#    puts e
#    require 'rubygems'
#end

require 'rubygems'
require 'pp'
require 'irb/completion'
require 'irb/ext/save-history'

# require ...
%w(
  wirble 
  map_by_method 
  what_methods
).each do |gem|
  # duration
    begin 
        require gem
    rescue LoadError
        puts "Error loading #{gem}. Run 'sudo gem install #{gem}'"
    end
end

# From http://www.alloycode.com/2010/6/26/automatic-color-coding-for-script-console-and-irb

IRB.conf[:SAVE_HISTORY] = 10000
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:USE_READLINE] = true
# IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"
IRB.conf[:PROMPT_MODE] = :SIMPLE

if Object.const_defined?(:Wirble)
    Wirble.init(:debug => true)
    Wirble.colorize
end


# object.local_methods
class Object 
    def local_methods(obj = self)
        obj.methods(false).sort
    end
end

# method finder
class Object
  def what?(*a)
    MethodFinder.new(self, *a) unless $in_method_find
  end
  def megaClone
    begin self.clone; rescue; self; end
  end
end
class MethodFinder
  def initialize( obj, *args )
    @obj = obj
    @args = args
  end
  def ==( val )
    MethodFinder.show( @obj, val, *@args )
  end
  
  # Find all methods on [anObject] which, when called with [args] return [expectedResult]
  def self.find( anObject, expectedResult, *args, &block )
    $in_method_find = true
    eval 'class DummyOut; def write(*args); end; end;'
    stdout, stderr = $stdout, $stderr
    $stdout = $stderr = DummyOut.new
    # change this back to == if you become worried about speed or something
    res = anObject.methods.select { |name| anObject.method(name).arity <= args.size }.
             select { |name| begin anObject.megaClone.method( name ).call( *args, &block ) == expectedResult; 
                             rescue Object; end }
    $stdout, $stderr = stdout, stderr
    $in_method_find = false
    res
  end
  
  # Pretty-prints the results of the previous method
  def self.show( anObject, expectedResult, *args, &block)
    find( anObject, expectedResult, *args, &block).each { |name|
      print "#{anObject.inspect}.#{name}" 
      print "(" + args.map { |o| o.inspect }.join(", ") + ")" unless args.empty?
      puts " == #{expectedResult.inspect}" 
    }
  end
end

# show_regexp - stolen from the pickaxe
def show_regexp(a, re)
   if a =~ re
      "#{$`}<<#{$&}>>#{$'}"
   else
      "no match"
   end
end
# Convenience method on Regexp so you can do
# /an/.show_match("banana")
class Regexp
    def show_match(a)
        show_regexp(a, self)
    end
end

require 'irb_callbacks'
require 'benchmark'
module IRB
    def self.around_eval(&block)
        @timing = Benchmark.realtime do
            block.call
        end
    end

    def self.after_output
        if @timing > 1
            puts "=> #{'%.3f' % @timing} seconds :("
        end
    end
end

# duration
# at_exit { puts Duration.new(Time.now - IRB_START_TIME) }

puts "OK"
load File.dirname(__FILE__) + '/.railsrc' if $0 == 'irb' && ENV['RAILS_ENV']


begin
  require "ap"
  IRB::Irb.class_eval do
    def output_value
      ap @context.last_value
    end
  end
rescue LoadError => e
  puts "ap gem not found.  Try typing 'gem install awesome_print' to get super-fancy output."
end

# require 'irb/completion'
# require 'irb/ext/save-history'
# 
# IRB.conf[:SAVE_HISTORY] = 1000
# IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
# 
# IRB.conf[:PROMPT_MODE] = :SIMPLE
# 
# %w[rubygems looksee/shortcuts wirble].each do |gem|
#   begin
#     require gem
#   rescue LoadError
#   end
# end
# 
# class Object
#   # list methods which aren't in superclass
#   def local_methods(obj = self)
#     (obj.methods - obj.class.superclass.instance_methods).sort
#   end
#   
#   # print documentation
#   #
#   #   ri 'Array#pop'
#   #   Array.ri
#   #   Array.ri :pop
#   #   arr.ri :pop
#   def ri(method = nil)
#     unless method && method =~ /^[A-Z]/ # if class isn't specified
#       klass = self.kind_of?(Class) ? name : self.class.name
#       method = [klass, method].compact.join('#')
#     end
#     puts `ri '#{method}'`
#   end
# end
# 
# def copy(str)
#   IO.popen('pbcopy', 'w') { |f| f << str.to_s }
# end
# 
# def copy_history
#   history = Readline::HISTORY.entries
#   index = history.rindex("exit") || -1
#   content = history[(index+1)..-2].join("\n")
#   puts content
#   copy content
# end
# 
# def paste
#   `pbpaste`
# end

# vim: ft=ruby
