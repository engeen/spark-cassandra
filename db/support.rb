
@is_test = ENV['RAILS_ENV'] == 'test'

def print_if_not_test(message)
  unless @is_test
    puts message
  end
end

def load_file(klass, separator = ';',filename = nil, withpath = true, csv_text = nil)
  _filename = withpath ? Rails.root.join('db', 'data', "#{filename || klass}.csv") : filename
  csv_text ||= File.read(_filename)
  csv = CSV.parse(csv_text, headers: true, col_sep: separator)
  print_if_not_test "loading #{klass}..."
  registered=[]
  klass.delete_all
  csv.each do |row|
    begin
      data_hash = row.to_hash.reject { |k, _v| !klass.new.respond_to?(:"#{k.to_s}=") }
      register = klass.new(data_hash)
      register.save!
      registered << register
    rescue Exception => e
      # byebug
      p "error: #{e} | #{row.to_hash} #{register.errors.inspect}"
    end
  end
  print_if_not_test "done #{klass}"
  return registered
end
