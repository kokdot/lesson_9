# frozen_string_literal: true

require_relative('instance_counter')
require_relative('validation')
# require_relative('acceessors')

class Route
  attr_reader :first, :last
  include Validation
  include InstanceCounter
  # validates_set
  # include Accessors
  # strong_attr_accessor :first, Station
  # strong_attr_accessor :last, Station

  def initialize(first, last)
    @first = first
    @last = last
    @intermediate_stations = []
    register_instance
    # register_validates
    self.class.validate :first, :type, Station
    self.class.validate :last, :type, Station
    validate!
  end

  # def validate!
  #   if @first.class != Station && @last.class != Station
  #     raise 'Вы должны ввести первую и последнюю станцию нового маршрута'
  #   end
  #   raise 'Станции должны быть разными' if @first == @last
  # end

  def add_station=(station)
    if @intermediate_stations.include?(station)
      puts "Станция #{station.name} уже была добавлена в этот маршрут ранее!"
    else
      @intermediate_stations << station
      puts "Станция #{station.name} добавлена"
    end
  end

  def remove_station=(station)
    if @intermediate_stations.include?(station)
      @intermediate_stations.delete(station)
      puts "Станция #{station.name} удалена"
    else
      puts "Станции #{station.name} нет на данном маршруте"
    end
  end

  def stations
    [@first, @intermediate_stations, @last].flatten
  end
end
