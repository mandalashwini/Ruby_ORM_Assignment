require_relative '../Model/Table'
require_relative '../Adapter/DBAdapter'
require_relative '../Model/Connection'
class User_table < Table
  puts "enter use table name.."
  table_name=gets.chomp
  if User_table.use(table_name)
    loop do
      puts "\n1.Search_Record\n2.Desc_table\n3.Add_records\n4.Update_Record\n5.Delete_Record\n6.Show_All_Records\n7.Exit\nEnter Your Choice..\n"
      ch=gets.chomp.to_i
      case ch
        when 1
          User_table.search(1)
        when 2
          User_table.desc_table
        when 3
          User_table.add_record(94799,'Sir viru')
        when 4
          User_table.updateRecord
        when 5
          User_table.deleteRecord(10)
        when 6
          User_table.getAllRecords
        when 7
          exit
        else
          puts "Wrong choice!!!"
      end
      puts "Do u want to continue..(y/n)"
      if gets.chomp=='n'
        break;
      end
    end

  else
    puts "#{table_name} does not exists"

  end

end