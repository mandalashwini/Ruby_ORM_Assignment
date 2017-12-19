require_relative '../../../RubyORM/config/initializer/config'
require 'mysql'
class DBAdapter
  module Adapter
    module MySql
      def self.connect
        con = Mysql.new(HOSTNAME, USERNAME, PASSWORD, DATABASE_NAME)
        return con
      end
    end
    module Postgresql
      def self.connect
        con = PG.connect :dbname => 'ruby', :user => 'root',
                         :password => 'password'
        return con
      end
    end
  end
  def adapter
    return @adapter if @adapter
    self.adapter=:MySql
    @adapter

  end
  def adapter=(adapter)
    @adapter=DBAdapter::Adapter.const_get(adapter.to_s)
  end
  def connect
    self.adapter.connect
  end
end
=begin
obj=DBAdapter.new
obj.connect
obj.adapter=:Postgresql
obj.connect
=end

=begin
obj=DBAdapter.new
con=obj.connect
rs = con.query('select * from student')
rs.each_hash { |h| puts h['name']}
con.close
=end
