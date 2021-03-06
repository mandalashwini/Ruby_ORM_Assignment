require_relative '../Adapter/DBAdapter'
require_relative 'Connection'
require 'mysql'
class Table
   def self.use()

     @con=Connection.instance.connect
     puts "enter use table name.."
     table_Name=gets.chomp
     tables=@con.query('show tables')
      tables.each_hash do |h|
       if h['Tables_in_ruby'].to_s == table_Name.to_s
         @tableName=table_Name
         return true
       end
     end
     return false
   end


  def self.getAllRecords
    rs = @con.query('select * from '+@tableName)
    rs.each_hash do  |h|
      h.each do |k,v|
        print " #{k} = #{v}"
      end
      puts
    end
  end

  def self.search(id)
   begin
     rs=@con.query('select * from '+@tableName+' where id='+id.to_s)
     raise if rs==nil
     rs_hash=rs.fetch_hash
     rs_hash.each do |k,v|
       print " #{k} = #{v} "
     end
     rescue
     puts "Record does not exist"
   end
  end

  def self.desc_table
    rs=@con.query('desc '+@tableName)
    rs.each_hash do  |h|
      puts " #{h['Field']} = #{h['Type']}"
    end

  end

  def self.add_record(*columns)

    @str="#{columns[0]}"+","
    i=1
    while i<columns.length
      if columns[i].class==String
        @str=@str+"\'"
        @str=@str+"#{columns[i]}"
        @str=@str+"\'"
      else
      @str=@str+"#{columns[i]}"
      end
      if i+1 != columns.length
        @str=@str+','
      end
      i=i+1
    end
    puts @str
     begin
        raise if rs=@con.query("insert into #{@tableName} values(#{@str})") !=nil
        puts "Successfully inserted"
      rescue
        puts "Something went wrong.."
      end

  end
  def self.deleteRecord(id)
    rs=@con.query("delete from #{@tableName} where id=#{id}")
    puts "The query has affected #{@con.affected_rows} rows"
  end
  def self.updateRecord
    puts "Enter field and updated_value you wanted to modify "
    u_column=gets.chomp
    puts "Enter field and updated_value you wanted to modify "
    u_value=gets.chomp.to_s
    puts "Enter field and value for where condition"
    w_column=gets.chomp
    puts "Enter field and value for where condition"
    w_value=gets.chomp
    print "update #{@tableName} set #{u_column} = '#{u_value}' where #{w_column} = #{w_value} \n"
    rs=@con.query("update #{@tableName} set #{u_column} = '#{u_value}' where #{w_column} = #{w_value}")
    puts "The query has affected #{@con.affected_rows} rows"
  end
end
