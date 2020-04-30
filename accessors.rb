module Accessors
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def strong_attr_accessor(name, type)
      var_name = "@#{name}".to_sym
      define_method("#{name}".to_sym) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        if type == "#{value.class}".to_sym 
          instance_variable_set(var_name, value)
        else
          raise "Тип данной переменной должен быть #{type}"
        end
      end
    end

    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        var_name_history = "@#{name}_history".to_sym
        self.instance_eval('var_name_h = Array.new')
        define_method(name) { instance_variable_get(var_name) }
        
        define_method("#{name}=".to_sym) do |value| 
          instance_variable_set(var_name, value)
          var_name_history << value
        end

        define_method("#{name}_history".to_sym) { puts var_name_history }
      end
    end
  end
end
