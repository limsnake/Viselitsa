# Класс WordReader, отвечающий за чтение слова для игры.
class WordReader
  def read_from_args # Ввод слова с консоли
    ARGV[0]
  end

  def read_from_file(file_name) # Случайное слово из файла
    begin
      f = File.new(file_name, 'r:UTF-8')
      lines = f.readlines # Читаем массив всех строк
      f.close
    rescue SystemCallError
      abort "Файл со словами не найден!"
    end
    lines.sample.chomp
  end
end
