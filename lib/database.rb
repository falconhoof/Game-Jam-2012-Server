set :database, ENV['DATABASE_URL']

if !database.table_exists?('users')
  migration "create users table" do
    database.create_table :users do
      primary_key :id
      String      :username
      String      :email
      index       :username, :unique => true
    end
  end
end

if !database.table_exists?('scores')
  migration "create the scores table" do
    database.create_table :scores do
      primary_key :id
      integer     :user_id
      integer     :score
    end
  end
end

if !database.table_exists?('statistics')
  migration "create the statistics table" do
    database.create_table :statistics do
      primary_key :id
      String      :name
      tring      :description
      integer     :counter, :default => 0
    end
  end
end