require 'addressable/uri'

::Url = Class.new Addressable::URI

module Gorillib::Factory
  class UrlFactory < Gorillib::Factory::ConvertingFactory
    self.product = ::Url
    def convert(obj) product.parse(obj) ; end
    register_factory!
  end
end
