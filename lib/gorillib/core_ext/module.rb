# It is necessary to override this ActiveSupport method
# due to the differences between #remove_method and #undef_method
Module.class_eval do
  def remove_possible_method(method)
    if method_defined?(method) || private_method_defined?(method)
      remove_method(method)
    end
  rescue NameError
  end
end
