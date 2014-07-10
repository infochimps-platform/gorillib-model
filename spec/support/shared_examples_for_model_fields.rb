shared_examples_for "a model field" do |field_name|
  it('gives the model a field'){ subject.class.should have_field(field_name) }

  context '#read_attribute' do
    it "if set, returns the value" do
      subject.write_attribute(field_name, sample_val)
      subject.read_attribute(field_name).should == sample_val
    end
    it "if unset, calls #read_unset_attribute" do
      subject.should_receive(:read_unset_attribute).with(field_name).and_return(mock_val)
      subject.read_attribute(field_name).should == mock_val
    end
    it "does **not** raise an error if the field does not exist (require 'model/lint' if you want it to)" do
       expect { subject.read_attribute(:fnord) }.not_to raise_error
    end
  end

  context '#write_attribute' do
    it('sets the value') do
      subject.write_attribute(field_name, sample_val)
      subject.read_attribute(field_name).should == sample_val
    end
    it('returns the new value') do
      subject.write_attribute(field_name, sample_val).should == sample_val
    end
    it "does **not** raise an error if the field does not exist (require 'model/lint' if you want it to)" do
      expect { subject.write_attribute(:fnord, 8) }.not_to raise_error
    end
  end

  context '#attribute_set?' do
    it('is true if the attribute has been set') do
      subject.write_attribute(field_name, sample_val)
      subject.attribute_set?(field_name).should be_true
    end
    it('is true if the attribute has been set, even to nil or false') do
      subject.write_attribute(field_name, nil)
      subject.attribute_set?(field_name).should be_true
    end
    it('is false if never written') do
      subject.attribute_set?(field_name).should be_false
    end
    it "does **not** raise an error if the field does not exist (require 'model/lint' if you want it to)" do
      expect { subject.attribute_set?(:fnord) }.not_to raise_error
    end
  end

  context "#receive_XX" do
    it('returns the new attribute') do
      subject.send("receive_#{field_name}", raw_val).should == sample_val
    end
    it('type-converts the object') do
      subject.send("receive_#{field_name}", raw_val)
      subject.read_attribute(field_name).should     == sample_val
      subject.read_attribute(field_name).should_not equal(sample_val)
    end
    it('uses a compatible object directly') do
      subject.send("receive_#{field_name}", sample_val)
      subject.read_attribute(field_name).should equal(sample_val)
    end
  end
end
