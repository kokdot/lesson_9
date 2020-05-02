module Validation
  def self.included(base)
    base.extend(ClassMethods)
  end
  module ClassMethods
    attr_accessor :validates
    # def validates_set
    #   # puts '123_validates_set'
    #   self.validates ||= [] #Array.new
    # end

    # def validates_get
    #   self.validates
    # end

    # def validate(*args)
    #   if args[1] == :presence
    #     # val = self.validates
    #     # @@validates << { atribut: args[0], type_proc: args[1] }
    #     self.validates << { atribut: args[0], type_proc: args[1] }
    #   elsif args[1] == :format  
    #     # @@validates << { atribut: args[0], type_proc: args[1], params: args[2] }
    #     self.validates << { atribut: args[0], type_proc: args[1], params: args[2] }
    #   elsif args[1] == :type  
    #     # @@validates << { atribut: args[0], type_proc: args[1], params: args[2] }
    #     self.validates << { atribut: args[0], type_proc: args[1], params: args[2] }
        
    #   end
    # end 
    def validate(attr, type, *params)
      self.validates ||= []
      self.validates << { attr: attr, type: type, params: params }
    end
  end 

  # def register_validates
  #   self.class.validates_set
  # end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end


  def validate!
    validates = self.class.validates
    p validates
    validates.each do |validate|
      value = instance_variable_get("@#{validate[:attr]}".to_sym)
      send("validate_#{validate[:type]}", value, *validate[:params])
      # if  value[:type] == :presence
      #   # check = atribut != nil && atribut != ''
      #   validate_presence(attr)
      # elsif value[:type].to_sym == :format
      #   # atribut = instance_variable_get("@#{value[:atribut]}".to_sym)
      #   # check =  value[:params].match(atribut)
      #   validate_format(attr, value[:params][0])
      # elsif value[:type].to_sym == :type
      #   # atribut = instance_variable_get("@#{value[:atribut]}".to_sym)
      #   # check = atribut.class == value[:params]
      #   validate_type(attr, value[:params][0])
      # end
    end
  end 

  private
 
  def validate_presence(value)
    raise "Вы не прошли проверку presence" if !(value != nil && value != '')
  end
 
  def validate_type(value, params)
    raise "Вы не прошли проверку format" if !value.class == params
  end
 
  def validate_format(value, params)
    raise "Вы не прошли проверку type" if !params.match(value)
  end
end 