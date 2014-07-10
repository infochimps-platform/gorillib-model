Object.class_eval do
  # Override this in a child if it cannot be dup'ed
  #
  # @return [Object]
  def try_dup
    self.dup
  end
end

[ TrueClass, FalseClass, Module, NilClass, Numeric, Symbol ].each  do |klass|
  klass.class_eval do
    def try_dup() self ; end
  end
end
