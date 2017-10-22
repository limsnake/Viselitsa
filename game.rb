
class Game

  def initialize(slovo)
    @letters = get_letters(slovo)
    @errors = 0
    @good_letters = []
    @bad_letters = []
    @status = 0 # Хранит статус игры
  end

  def get_letters (slovo)
    if slovo == nil || slovo == ""
      abort "Вы не ввели слово для игры"
    end

    slovo = UnicodeUtils.upcase(slovo.encode('UTF-8'))
    slovo.split("")
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

  # Вынесем пунтк 2 в отдельный метод
  # 1. Должен проверить наличие букв в загаданном слове
  # 2. Или среди уже названных букв (массивы @good_letters/bad_letters)

  def next_step(bukva)
    bukva = UnicodeUtils.upcase(bukva)

    if @status == -1 || @status == 1 # -1 проиграна игра, а 1 - выйграна
      return
    end

    bukva_x = bukva
    if bukva == "е"
      bukva_x = "ё"
    elsif bukva == "ё"
      bukva_x = "е"
    elsif bukva == "и"
      bukva_x = "й"
    elsif bukva == "й"
      bukva_x = "и"
    end

    if @good_letters.include?(bukva) || @bad_letters.include?(bukva) ||
      @good_letters.include?(bukva_x) || @bad_letters.include?(bukva_x)
      return
    end

    if @letters.include?(bukva) || @letters.include?(bukva_x)

      if bukva_x == "й" || bukva_x == "ё"
        @good_letters << bukva
      else
        @good_letters << bukva_x
      end

      if @good_letters.size == @letters.uniq.size
        @status = 1
      end

    else
      @bad_letters << bukva

      @errors += 1

      if errors >= 7
        @status = -1
      end
    end
  end

  def letters
    @letters
  end

  def good_letters
    @good_letters
  end

  def bad_letters
    @bad_letters
  end

  def status
    @status
  end

  def errors
    @errors
  end
end
