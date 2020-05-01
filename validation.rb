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
    def validate(atribut, type_proc, *params)
      self.validates ||= []
      self.validates << { atribut: atribut, type_proc: type_proc, params: params }
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

  # private
  def validate_presence?(atribut)
    atribut != nil && atribut != ''
  end
  def validate_type?(atribut, params)
    atribut.class == params
  end
  def validate_format?(atribut, params)
    params.match(atribut)
  end

  def validate!
    validates = self.class.validates
    p validates
    validates.each do |value|
      atribut = instance_variable_get("@#{value[:atribut]}".to_sym)
      if  value[:type_proc] == :presence
        # check = atribut != nil && atribut != ''
        raise "Вы не прошли проверку presence" if !validate_presence?(atribut)
      elsif value[:type_proc].to_sym == :format
        # atribut = instance_variable_get("@#{value[:atribut]}".to_sym)
        # check =  value[:params].match(atribut)
        raise "Вы не прошли проверку format" if !validate_format?(atribut, value[:params][0])
      elsif value[:type_proc].to_sym == :type
        # atribut = instance_variable_get("@#{value[:atribut]}".to_sym)
        # check = atribut.class == value[:params]
        raise "Вы не прошли проверку type" if !validate_type?(atribut, value[:params][0])
      end
    end
  end  
end 