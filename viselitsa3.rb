
require_relative "lib/game.rb"
require_relative "lib/result_printer.rb"
require_relative "lib/word_reader.rb"

current_path = './' + File.dirname(__FILE__)

VERSION = "Игра Виселица, версия 4\n\n"

reader = WordReader.new

if reader.read_from_args == nil
  word = reader.read_from_file(current_path + "/data/word.txt")
else
  word = reader.read_from_args
end

game = Game.new(word)
game.version = VERSION
printer = ResultPrinter.new(game)

while game.in_progress? do
  printer.print_status(game)
  game.ask_next_letter
end

printer.print_status(game)
