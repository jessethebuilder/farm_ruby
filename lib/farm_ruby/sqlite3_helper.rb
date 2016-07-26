module Sqlite3Helper
  def save_attributes(db, table_name, attributes)
    db.execute("INSERT INTO #{table_name} (#{attributes.map{ |a| a.to_s }.join(',')})
                 VALUES (#{attributes.count.times.map{ '?' }.join(',')})",
                 attributes.map{ |a| self.send(a) })
    db.last_insert_row_id
  end
end
