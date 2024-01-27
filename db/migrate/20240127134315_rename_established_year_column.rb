class RenameEstablishedYearColumn < ActiveRecord::Migration[7.1]
  def change
    rename_column :companies, :setablished_year, :established_year
  end
end
