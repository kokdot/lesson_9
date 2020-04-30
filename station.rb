# frozen_string_literal: true

require_relative('validation')
require_relative('instance_counter')

class Station
  include InstanceCounter
  include Validation
  # validates_set
  attr_reader :name
  @@stations = []
  NAME_FORMAT = /^([А-Я]|[A-Z])([а-я]|[a-z]){5,}\d*/.freeze

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
    register_validates
    self.class.validate :name, :format, NAME_FORMAT
    self.class.validate :name, :presence
    validate!
  end

  def handler
    @trains.each { |train| yield(train) }
  end

  # def validate!
  #   raise 'В названии должно быть минимум 6 символов' if @name.length < 6
  #   raise 'Не правильный формат названия станции' if @name !~ NAME_FORMAT
  # end

  def self.all
    @@stations
  end

  def to_s
    @name
  end

  def get_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def list_trains
    @trains.each { |train| puts train.number }
  end

  def type_trains
    cargo = @trains.count { |train| train.class == CargoTrain }
    passenger = @trains.count { |train| train.class == PassengerTrain }
    puts "В данный момент на станци находится #{cargo} грузовых поездов и #{passenger} пассажирских поездов."
  end
end
