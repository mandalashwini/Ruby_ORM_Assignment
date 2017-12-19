require_relative '../Adapter/DBAdapter'
require 'mysql'
class Connection
  def initialize
    @obj=DBAdapter.new
  end
  @@instance = Connection.new
  def self.instance
    return @@instance
  end
  def connect
    @con=@obj.connect
    return @con
  end
  private_class_method :new
end