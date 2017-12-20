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
    if DATABASE_TYPE.eql?"mysql"
      self.adapter.connect
    else
      abort("PlSql not supported..")
    end
  end

end
