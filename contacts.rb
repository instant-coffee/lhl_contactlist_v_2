require 'pg'

class Contact

  # puts "establishing connection ..."
  CONN = PG.connect(
    dbname: 'd1d1ldrft5ec1a',
    port: 5432,
    user: 'kxxpkkmoksrpgm',
    host: 'ec2-23-23-215-150.compute-1.amazonaws.com',
    password: 'G8fbibIaN40dPcaNMWN3lAbJa4'
   
  )
  
  attr_accessor :firstname , :lastname, :email
  attr_reader :id

  def initialize(firstname, lastname, email)
    @firstname = firstname
    @lastname = lastname
    @email = email
  end

  def is_new?
    @id.nil?
  end

  def save
    #raise 'Invalid Instructor!' unless valid?
    if is_new?
      result = CONN.exec_params('INSERT INTO contacts (firstname, lastname, email) VALUES ($1, $2, $3) returning id', [@firstname, @lastname, @email])
      @id = result[0]['id']
    else
      CONN.exec_params('UPDATE contacts SET firstname = $1, lastname = $2 email = $3 WHERE id = $4', [@firstname, @lastname, @email, @id])
    end
  end
# puts "Closing the db connection..."
# CONN.close
 
# puts "DONE"
end