require_relative 'serialization/to_wire'
require_relative 'serialization/lines'
require_relative 'serialization/csv'
require_relative 'serialization/tsv'
require_relative 'serialization/json'

class Array
  def to_tsv
    to_wire.join("\t")
  end
end

module Gorillib
  module Model

    def to_wire(options={})
      compact_attributes.merge(:_type => self.class.typename).inject({}) do |acc, (key,attr)|
        acc[key] = attr.respond_to?(:to_wire) ? attr.to_wire(options) : attr
        acc
      end
    end
    def as_json(*args) to_wire(*args) ; end

    def to_json(options={})
      MultiJson.dump(to_wire(options), options)
    end

    def to_tsv(options={})
      attributes.map do |key, attr|
        attr.respond_to?(:to_wire) ? attr.to_wire(options) : attr
      end.join("\t")
    end

    module ClassMethods
      def from_tuple(*vals)
        receive Hash[field_names[0..vals.length-1].zip(vals)]
      end
    end

  end
end
