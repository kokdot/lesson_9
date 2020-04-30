# Написать модуль Acсessors, содержащий следующие методы, которые можно вызывать на уровне класса:

# метод   
# attr_accessor_with_history
 
#  Этот метод динамически создает геттеры и сеттеры для любого кол-ва атрибутов, при этом 
# сеттер сохраняет все значения инстанс-переменной при изменении этого значения. 
# Также в класс, в который подключается модуль должен добавляться инстанс-метод  
module Accessors
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        var_name_h = "@#{name}_h".to_sym
        # var_name_h.send('Array.new')
        self.instance_eval('var_name_h = Array.new')
        # var_name_h.send('Array.new')
        define_method(name) { instance_variable_get(var_name) }
        
        define_method("#{name}=".to_sym) do |value| 
          instance_variable_set(var_name, value)
          var_name_h << value
          # self.instance_eval('var_name_h << value')
        end

        define_method("#{name}_h".to_sym) do 
          p var_name_h
          # self.instance_eval('puts var_name_h')
          end 
          # var_name_h.send('||='.to_sym,[])
          # var_name_h.send(:<<,value)
          # self.instance_eval('')
          # instance_variable_get(var_name_h) 
        # end
        
        # define_method("#{name}_h") { instance_variable_get(var_name_h) }
      end
    end
  end

 
end
