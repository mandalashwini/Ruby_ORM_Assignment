require_relative '../Model/Table'
require_relative '../Adapter/DBAdapter'
require_relative '../Model/Connection'
class User_table < Table
  puts User_table.use("student")
  User_table.search(181)
  User_table.desc_table
  User_table.add_record(94009,'Sir viru',4)
end