
require 'sequel'

Sequel.migration do
  change do

    create_table(:image_sources) do
      primary_key :id
      String :img_src
      String :attribution_url
      Datetime :created_at
      Datetime :updated_at

      index :img_src, :unique => true
    end

  end
end
