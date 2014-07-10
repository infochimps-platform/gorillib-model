shared_context 'model', :model_spec => true do

  module Gorillib ;               module Test ;       end ; end
  module Meta ; module Gorillib ; module Test ; end ; end ; end

  after(:each){ Gorillib::Test.nuke_constants ; Meta::Gorillib::Test.nuke_constants }

  let(:mock_val){ double('mock value') }

  let(:smurf_class) do
    class Gorillib::Test::Smurf
      include Gorillib::Model
      field :name,       String
      field :smurfiness, Integer
      field :weapon,     Symbol
    end
    Gorillib::Test::Smurf
  end
  let(:papa_smurf   ){ smurf_class.receive(:name => 'Papa Smurf', :smurfiness => 9,  :weapon => 'staff') }
  let(:smurfette    ){ smurf_class.receive(:name => 'Smurfette',  :smurfiness => 11, :weapon => 'charm') }

  let(:smurf_collection_class) do
    smurf_class
    class Gorillib::Test::SmurfCollection < Gorillib::ModelCollection
      include Gorillib::Collection::ItemsBelongTo
      self.item_type        = Gorillib::Test::Smurf
      self.parentage_method = :village
    end
    Gorillib::Test::SmurfCollection
  end

  let(:smurf_village_class) do
    smurf_class ; smurf_collection_class
    module Gorillib::Test
      class SmurfVillage
        include Gorillib::Model
        field      :name,   Symbol
        collection :smurfs, SmurfCollection, item_type: Smurf, key_method: :name
      end
    end
    Gorillib::Test::SmurfVillage
  end

  let(:smurfhouse_class) do
    module Gorillib::Test
      class Smurfhouse
        include Gorillib::Model
        field   :shape, Symbol
        field   :color, Symbol
      end
    end
    Gorillib::Test::Smurfhouse
  end

end
