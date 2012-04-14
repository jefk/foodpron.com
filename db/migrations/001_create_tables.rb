
require 'sequel'

Sequel.migration do
  change do

    create_table(:image_sources) do
      primary_key :id
      String :src
      String :attribution_url
      Numeric :score, :default => 0
      Datetime :created_at
      Datetime :updated_at

      index :src, :unique => true
    end

  end
end
