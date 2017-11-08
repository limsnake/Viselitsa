# Основной класс игры Game. Хранит состояние игры и предоставляет функции для
# развития игры (ввод новых букв, подсчет кол-ва ошибок и т. п.).
require "unicode_utils/upcase"

class Game
  # Сокращенный способ записать сеттеры для получения информации об игре
  attr_reader :errors, :status, :good_letters, :bad_letters, :letters
  # Сокращенный способ записать и сеттер и геттер для поля version
  attr_accessor :version

  # Константа с максимальным количеством ошибок
  MAX_ERRORS = 7

  def initialize(word)
    @letters = get_letters(word)
    @errors = 0
    @good_letters = []
    @bad_letters = []

    # В поле @status лежит символ, который наглядно показывает статус
    # :in_progress — игра продолжается
    # :won — игра выиграна
    # :lost — игра проиграна
    @status = :in_progress
  end

  def max_errors
    MAX_ERRORS
  end

  # Метод, который возвращает количество оставшихся ошибок
  def errors_left
    MAX_ERRORS - @errors
  end

  def get_letters(word)
    if word.nil? || word == ""
      abort "Вы не ввели слово для игры"
    else
      word = UnicodeUtils.upcase(word.encode('UTF-8'))
    end

    word.split("")
  end

  # 1. Попросить букву c консоли
  # 2. Проверить результат
  def ask_next_letter
    puts "\nВведите следующую букву"

    letter = ""

    while letter == "" do
      letter = STDIN.gets.encode("UTF-8").chomp
    end

    next_step(letter)
  end

  # Метод, который отвечает на вопрос, является ли буква подходящей
  def is_good?(letter)
    @letters.include?(letter) ||
      (letter == "Е" && @letters.include?("Ё")) ||
      (letter == "Ё" && @letters.include?("Е")) ||
      (letter == "И" && @letters.include?("Й")) ||
      (letter == "Й" && @letters.include?("И"))
  end

  # Метод добавляет букву к массиву (хороших или плохих букв)
  def add_letter_to(letters, letter)
    letters << letter

    case letter
      when "И" then letters << "Й"
      when "Й" then letters << "И"
      when "Е" then letters << "Ё"
      when "Ё" then letters << "Е"
    end
  end

  # Метод, который отвечает на вопрос, была ли уже эта буква
  def repeated?(letter)
    @good_letters.include?(letter) || @bad_letters.include?(letter)
  end

  def lost?
    @status == :lost || @errors >= MAX_ERRORS
  end

  def in_progress?
    @status == :in_progress
  end

  def won?
    @status == :won
  end

  def next_step(letter)
    letter = UnicodeUtils.upcase(letter)

    return if @status == :lost || @status == :won
    return if repeated?(letter)

    if is_good?(letter)
      add_letter_to(@good_letters, letter)
      if @good_letters.size == @letters.uniq.size
        @status = :won
      end
    else
      add_letter_to(@bad_letters, letter)

      @errors += 1

      @status = :lost if lost?
    end
  end
end
