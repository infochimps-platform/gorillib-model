shared_examples_for 'a model' do

  context 'initialize' do
    it "has no required args" do
      obj = smurf_class.new
      obj.compact_attributes.should == {}
    end
    it "takes the last hashlike arg as the attributes" do
      obj = smurf_class.new :smurfiness => 3, :weapon => :smurfchucks
      obj.compact_attributes.should == { :smurfiness => 3, :weapon => :smurfchucks }
    end

    context 'positional args' do
      before do
        smurf_class.fields[:smurfiness].position = 0
        smurf_class.fields[:weapon    ].position = 1
      end
      it "takes all preceding args as positional, clobbering values set in attrs" do
        obj = smurf_class.new 7,   :smurfing_stars
        obj.compact_attributes.should == { :smurfiness => 7, :weapon => :smurfing_stars }
        obj = smurf_class.new 7,   :smurfing_stars, :smurfiness => 3, :weapon => :smurfchucks
        obj.compact_attributes.should == { :smurfiness => 7, :weapon => :smurfing_stars }
      end
      it "does nothing special with a nil positional arg -- it clobbers anything there setting the attribute to nil" do
        obj = smurf_class.new nil, :smurfiness => 3
        obj.compact_attributes.should == { :smurfiness => nil }
      end
      it "raises an error if too many positional args are given" do
        ->{ smurf_class.new 7, :smurfing_stars, :azrael }.should raise_error(ArgumentError, /wrong number of arguments.*3.*0\.\.2/)
      end
      it "always takes the last hash arg as the attrs -- even if it is in the positional slot of a hash field" do
        smurf_class.field :hashie, Hash, :position => 2
        obj = smurf_class.new({:smurfiness => 3, :weapon => :smurfiken})
        obj.compact_attributes.should == { :smurfiness => 3, :weapon => :smurfiken }
        obj = smurf_class.new(3, :smurfiken, { :weapon => :bastard_smurf })
        obj.compact_attributes.should == { :smurfiness => 3, :weapon => :smurfiken }
        obj = smurf_class.new(3, :smurfiken, {:this => :that}, { :weapon => :bastard_smurf })
        obj.compact_attributes.should == { :smurfiness => 3, :weapon => :smurfiken, :hashie => {:this => :that} }
      end
      it "skips fields that are not positional args" do
        smurf_class.fields[:weapon].unset_attribute(:position)
        smurf_class.field :color, String, :position => 1
        smurf_class.new(99, 'cerulean').compact_attributes.should == { :smurfiness => 99, :color => 'cerulean' }
      end
    end
  end

  context 'receive' do
    let(:my_attrs){ { :smurfiness => 900, :weapon => :wood_smurfer } }
    let(:subklass){ class ::Gorillib::Test::SubSmurf < smurf_class ; end ; ::Gorillib::Test::SubSmurf }

    it "returns nil if given a single nil arg" do
      smurf_class.receive(nil).should == nil
    end
    it "returns the object if given a single object of the model class" do
      smurf_class.receive(papa_smurf).should equal(papa_smurf)
    end
    it "raises an error if the attributes are not hashlike" do
      ->{ smurf_class.receive('DURRRR') }.should raise_error(ArgumentError, /attributes .* like a hash: "DURRRR"/)
    end
    context "with hashlike args," do
      before{ Gorillib::Factory.send(:factories).reject!{|th, type| th.to_s =~ /gorillib\.test/ }}

      it "instantiates the object, passing it the attrs and block" do
        my_attrs = { :smurfiness => 900, :weapon => :wood_smurfer }
        smurf_class.should_receive(:new).with(my_attrs)
        smurf_class.receive(my_attrs)
      end
      it "retrieves the right factory if :_type is present" do
        my_attrs = self.my_attrs.merge(:_type => 'gorillib.test.smurf')
        smurf_class.should_receive(:new).with(my_attrs)
        smurf_class.receive(my_attrs)
      end
      it "retrieves the right factory if :_type is present" do
        my_attrs = self.my_attrs.merge(:_type => 'gorillib.test.sub_smurf')
        subklass.should_receive(:new).with(my_attrs)
        smurf_class.receive(my_attrs)
      end
      it 'complains if the given type is not right' do
        mock_factory = double('factory') ; mock_factory.stub(:receive! => {}, :receive => double, :new => mock_factory)
        mock_factory.should_receive(:<=).and_return(false)
        smurf_class.should_receive(:warn).with(/factory .* is not a type of Gorillib::Test::Smurf/)
        smurf_class.receive(:my_field => 12, :acme => 3, :_type => mock_factory)
      end
    end
  end
end
