
require 'sequel'

Sequel.migration do
  change do

    create_table(:images) do
      primary_key :id
      Integer :pron_id
      String :src
      String :attribution_url
      BigDecimal :score, :size => [12,3], :default => 0
      Datetime :created_at
      Datetime :updated_at

      index :src, :unique => true
    end

    create_table(:prons) do
      primary_key :id
      Integer :image_id
      Datetime :created_at
      Datetime :updated_at
    end

  end
end
