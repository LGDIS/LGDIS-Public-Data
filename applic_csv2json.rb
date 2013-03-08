# encoding: utf-8

require 'json'
require 'csv'

JSON_FILE_PATH = "./master.json"
APPLIC_MASTER_DIR = "./"
APPLIC_MASTER_FILES = {
  "sex"                             => "APPLIC【コード辞書（共通）_03】.Sex.csv",
  "in_city_flag"                    => "APPLIC【コード辞書（防災情報共有）_15】.OutOfTownType.csv",
  "refuge_status"                   => "APPLIC【コード辞書（防災情報共有）_16】.EvacuationType.csv",
  "injury_flag"                     => "APPLIC【コード辞書（防災情報共有）_17】.Injury.csv",
  "allergy_flag"                    => "APPLIC【コード辞書（防災情報共有）_18】.Allergy.csv",
  "pregnancy"                       => "APPLIC【コード辞書（防災情報共有）_19】.PregnantType.csv",
  "baby"                            => "APPLIC【コード辞書（防災情報共有）_20】.InfantType.csv",
  "upper_care_level_three"          => "APPLIC【コード辞書（防災情報共有）_21】.CareType.csv",
  "elderly_alone"                   => "APPLIC【コード辞書（防災情報共有）_22】.SingleAged65.csv",
  "elderly_couple"                  => "APPLIC【コード辞書（防災情報共有）_23】.CoupleAged65.csv",
  "bedridden_elderly"               => "APPLIC【コード辞書（防災情報共有）_24】.Bedridden.csv",
  "elderly_dementia"                => "APPLIC【コード辞書（防災情報共有）_25】.Dementia.csv",
  "rehabilitation_certificate"      => "APPLIC【コード辞書（防災情報共有）_26】.CureType.csv",
  "physical_disability_certificate" => "APPLIC【コード辞書（防災情報共有）_27】.DisabilityType.csv"}

all_data = {}
APPLIC_MASTER_FILES.each do |key, filename|
  data = {}
  CSV.open(APPLIC_MASTER_DIR + filename, "r", {:encoding => "utf-8"}) do |csv|
    csv.each do |row|
      code, val = *row
      data[code] = val
    end
  end
  all_data[key] = data
end


File.open(JSON_FILE_PATH, "w:utf-8") do |f|
  f.write(JSON.generate(all_data))
end
