module Gorillib
  module Model
    module NamedSchema

    protected

      #
      # Returns the meta_module -- a module extending the type, on which all the
      # model methods are inscribed. This allows you to override the model methods
      # and call +super()+ to get the generic behavior.
      #
      # The meta_module is named for the including class, but with 'Meta::'
      # prepended and 'Type' appended -- so Geo::Place has meta_module
      # "Meta::Geo::PlaceType"
      #
      def meta_module
        return @_meta_module if defined?(@_meta_module)
        if self.name
          @_meta_module = ::Gorillib::Model::NamedSchema.get_nested_module("Meta::#{self.name}Type")
        else
          @_meta_module = Module.new
        end
        self.class_eval{ include(@_meta_module) }
        @_meta_module
      end

      def define_meta_module_method(method_name, visibility=:public, &block)
        if (visibility == false) then return               ; end
        if (visibility == true)  then visibility = :public ; end
        Validate.included_in!("visibility", visibility, [:public, :private, :protected])
        meta_module.module_eval{ define_method(method_name, &block) }
        meta_module.module_eval "#{visibility} :#{method_name}", __FILE__, __LINE__
      end

      # Returns a module for the given names, rooted at Object (so
      # implicity with '::').
      # @example
      #   get_nested_module(["This", "That", "TheOther"])
      #   # This::That::TheOther
      def self.get_nested_module(name)
        name.split('::').inject(Object) do |parent_module, module_name|
          # inherit = false makes these methods be scoped to parent_module instead of universally
          if parent_module.const_defined?(module_name, false)
            parent_module.const_get(module_name, false)
          else
            parent_module.const_set(module_name.to_sym, Module.new)
          end
        end
      end

    end
  end
end
