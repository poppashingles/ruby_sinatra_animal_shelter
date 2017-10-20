require_relative('../db/sql_runner')

class Animal

  attr_reader :id, :owner_id
  attr_accessor :name, :type, :adoptable, :admission_date, :adopted_date, :photo_url

  def initialize(params)
    @id = params['id'].to_i()
    @name = params['name']
    @type = params['type']
    @adoptable = params['adoptable']
    @admission_date = params['admission_date']
    # @adopted_date = params['adopted_date']
    @photo_url = params['photo_url']
    @owner_id = params['owner_id'].to_i()
  end

  def save()
    sql = "INSERT INTO animals (name, type, adoptable, admission_date, photo_url, owner_id)
          VALUES($1, $2, $3, $4, $5, $6) RETURNING *"
    values = [@name, @type, @adoptable, @admission_date, @photo_url, @owner_id]
    animal_data = SqlRunner.run(sql, values)[0]
    @id = animal_data['id'].to_i()
  end

  def self.all()
    sql = "SELECT * FROM animals"
    values = []
    results = SqlRunner.run(sql, values)
    return results.map { |animal| Animal.new(animal)}
  end

end