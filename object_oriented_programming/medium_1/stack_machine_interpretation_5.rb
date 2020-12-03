# Stack Machine Interpretation

# This is one of the hardest exercises in this exercise set. It uses both exceptions and Object#send, neither of which we've discussed in detail before now. Think of this exercise as one that pushes you to learn new things on your own, and don't worry if you can't solve it.

# You may remember our Minilang language from back in the RB101-RB109 Medium exercises. We return to that language now, but this time we'll be using OOP. If you need a refresher, refer back to that exercise.

# Write a class that implements a miniature stack-and-register-based programming language that has the following commands:

# n Place a value n in the "register". Do not modify the stack.
# PUSH Push the register value on to the stack. Leave the value in the register.
# ADD Pops a value from the stack and adds it to the register value, storing the result in the register.
# SUB Pops a value from the stack and subtracts it from the register value, storing the result in the register.
# MULT Pops a value from the stack and multiplies it by the register value, storing the result in the register.
# DIV Pops a value from the stack and divides it into the register value, storing the integer result in the register.
# MOD Pops a value from the stack and divides it into the register value, storing the integer remainder of the division in the register.
# POP Remove the topmost item from the stack and place in register
# PRINT Print the register value
# All operations are integer operations (which is only important with DIV and MOD).

# Programs will be supplied to your language method via a string passed in as an argument. Your program should produce an error if an unexpected item is present in the string, or if a required stack value is not on the stack when it should be (the stack is empty). In all error cases, no further processing should be performed on the program.

# You should initialize the register to 0.

# LS Solution

require 'set'

class MinilangError < StandardError; end
class BadTokenError < MinilangError; end
class EmptyStackError < MinilangError; end

class Minilang
  ACTIONS = Set.new %w(PUSH ADD SUB MULT DIV MOD POP PRINT)

  def initialize(program)
    @program = program
  end

  def eval(param = nil)   # Lifted from Matthew Johnston's solution
    puts "Top of eval"
    program = @program

    puts "@program = #{@program}" if param
    puts "param = #{param}" if param
    program = format(@program, param) if param
    puts "program = #{program} (After format)" if param

    @stack = []
    @register = 0
    program.split.each { |token| eval_token(token) }
  rescue MinilangError => error
    puts error.message
  end

  private

  def eval_token(token)
    puts "Top of eval_token: token = #{token}"

    if ACTIONS.include?(token)
      send(token.downcase)
    elsif token =~ /\A[-+]?\d+\z/
      @register = token.to_i
    else
      raise BadTokenError, "Invalid token: #{token}"
    end
    puts "Bottom of eval_token"
  end

  def push
    @stack.push(@register)
  end

  def pop
    raise EmptyStackError, "Empty stack!" if @stack.empty?
    puts "Following line in pop()"
    @register = @stack.pop
  end

  def add
    @register += pop
  end

  def div
    @register /= pop
  end

  def mod
    @register %= pop
  end

  def mult
    @register *= pop
  end

  def sub
    @register -= pop
  end

  def print
    puts @register
  end
end


Minilang.new('POP 7 8').eval
# Minilang.new('PRINT').eval
# # 0

# Minilang.new('5 PUSH 3 MULT PRINT').eval
# # 15

# Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# # 5
# # 3
# # 8

# Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# # 10
# # 5

# Minilang.new('5 PUSH POP POP PRINT').eval
# # Empty stack!

# Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# # 6

# Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# # 12

# Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# # Invalid token: XSUB

# Minilang.new('-3 PUSH 5 SUB PRINT').eval
# # 8

# Minilang.new('6 PUSH').eval
# # (nothing printed; no PRINT commands)


# # Further Exploration 1

# puts "FEFEFEFEFE"

# # CENTIGRADE_TO_FAHRENHEIT =
# #   '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'
# # MinilangFE1.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: 100)).eval
# # # 212
# # MinilangFE1.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: 0)).eval
# # # 32
# # MinilangFE1.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: -40)).eval
# # # -40

# # puts CENTIGRADE_TO_FAHRENHEIT

# # puts format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: 100)

# CENTIGRADE_TO_FAHRENHEIT =
#   '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'
# minilang = Minilang.new(CENTIGRADE_TO_FAHRENHEIT)
# puts "Convert CENTIGRADE_TO_FAHRENHEIT "

# minilang.eval(degrees_c: 100)
# # 212
# minilang.eval(degrees_c: 0)
# # 32
# minilang.eval(degrees_c: -40)
# # -40

# # Further Exploration 1 Suggestion (F => C)

# FAHRENHEIT_TO_CENTIGRADE =
#   '9 PUSH 160 PUSH %<degrees_f>d PUSH 5 MULT SUB DIV PRINT'
#   minilang = Minilang.new(FAHRENHEIT_TO_CENTIGRADE)
#   puts "Convert FAHRENHEIT_TO_CENTIGRADE "

#   minilang.eval(degrees_f: 212)
#   # 100
#   minilang.eval(degrees_f: 32)
#   # 0
#   minilang.eval(degrees_f: -40)
#   # -40
  
#   # Further Exploration 1 Suggestion (m/h => km/h)
#   # Using k(m) = (5/3)m
#   MPH_TO_KMH =
#   '3 PUSH %<miles>d PUSH 5 MULT DIV PRINT'
#   minilang = Minilang.new(MPH_TO_KMH)

#   puts "Convert MPH_TO_KMH"
#   minilang.eval(miles: 6)
#   # 10

#   # Further Exploration 1 Suggestion (compute area of a rectangle)

#   AREA_OF_RECT =
#   '%<length>d PUSH %<width>d MULT PRINT'
#   minilang = Minilang.new(AREA_OF_RECT)

#   puts "AREA_OF_RECT"
#   # minilang.eval(6, 4)
#   minilang.eval(length: 6, width: 4)
#   # 24

# # LS Further Exploration 2
# # I don't see the ambiguity
