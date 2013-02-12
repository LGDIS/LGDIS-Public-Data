# -*- coding: utf-8 -*-
require 'csv'
require 'dalli'

class LoadData

  # memcachedサーバ(ホスト名:ポート番号)
  MEMCACHED = 'localhost:11211'
  # ロード対象CSVファイルのあるディレクトリ
  CSV_PATH = '.'#'/home/rails/LGDxx/lib/batches'

  @mc = nil

  # memcachedへのデータロード
  # CSV_PATHにある所定ファイルをすべてロードする
  def execute
    begin
      puts "start"
      @mc = Dalli::Client.new(MEMCACHED)
      # 地区(大分類)
      store_csv(File.join(CSV_PATH, 'area.csv'))
      # 地区(小分類)
      state  = Hash.new
      city   = Hash.new
      street = Hash.new
      store_csv(File.join(CSV_PATH, 'address.csv')) do |row|
        state[row[0][0..1]]  = row[1]
        city[row[0][0..4]]   = row[2]
        street[row[0][0..7]] = row[3]
      end
      @mc.set("state", state)
      @mc.set("city", city)
      @mc.set("street", street)
      # その他
      store_csv(File.join(CSV_PATH, 'gathering_position.csv'))
      store_csv(File.join(CSV_PATH, 'predefined_position.csv'))
      Dir.glob(File.join(CSV_PATH, '??_????.csv')) do |path|
        store_csv(path)
      end
      puts "done."
      return 0
    rescue => e
      STDOUT.puts "ERROR: #{e.message}"
      STDOUT.puts e.backtrace
      return 1
    end
  end

  # CSVファイル内容をmemcachedにストアする
  # ※ブロック指定時はブロックに処理を提供する
  def store_csv(file, options={}, &block)
    CSV.open(file, "r", {:headers => :first_row, :encoding => "utf-8"}) do |csv|
      puts "import: #{file}..."
      csv.each do |row|
        if block_given?
          yield row
        else
          @mc.set(row[0], row.to_hash)
        end
      end
    end
  end
end

LoadData.new.execute if $0 == __FILE__
