module Validation
  def self.included(base)
    base.extend(ClassMethods)
  end
 module ClassMethods
  attr_accessor :validates
    def validates_set
      # puts '123_validates_set'
      self.validates ||= Array.new
    end

    def validates_get
      self.validates
    end

    def validate(*args)
      if args[1] == :presence
        # val = self.validates
        # @@validates << { atribut: args[0], type_proc: args[1] }
        self.validates << { atribut: args[0], type_proc: args[1] }
      elsif args[1] == :format  
        # @@validates << { atribut: args[0], type_proc: args[1], params: args[2] }
        self.validates << { atribut: args[0], type_proc: args[1], params: args[2] }
      elsif args[1] == :type  
        # @@validates << { atribut: args[0], type_proc: args[1], params: args[2] }
        self.validates << { atribut: args[0], type_proc: args[1], params: args[2] }
        
      end
    end 
  end 

   def register_validates
    self.class.validates_set
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  # private

  def validate!
    validates = self.class.validates_get
    # p validates
    validates.each do |value|
      if  value[:type_proc] == :precence
        atribut = instance_variable_get("@#{value[:atribut]}".to_sym)
        check = atribut != nil && atribut != ''
        raise "Вы не прошли проверку presence" if !check
      elsif value[:type_proc].to_sym == :format
        atribut = instance_variable_get("@#{value[:atribut]}".to_sym)
        check =  value[:params].match(atribut)
        raise "Вы не прошли проверку format" if !check
      elsif value[:type_proc].to_sym == :type
        atribut = instance_variable_get("@#{value[:atribut]}".to_sym)
        check = atribut.class == value[:params]
        raise "Вы не прошли проверку type" if !check
      end
    end
  end  
end 