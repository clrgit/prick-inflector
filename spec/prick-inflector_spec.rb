describe Prick::Inflector do
  it 'has a version number' do
    expect(Prick::Inflector::VERSION).not_to be_nil
  end

  describe "#self.pluralize" do
    def pl(s) = Prick::Inflector.pluralize(s)
    
    it "pluralizes a word" do
      expect(pl "dog").to eq "dogs"
    end

    context "when word is uncountable" do
      it "adds -es if word ends with an 's'" do
        expect(pl "news").to eq "newses"
      end
      it "adds -s otherwise" do
        expect(pl "sheep").to eq "sheeps"
      end
    end
  end

  describe "#self.singularize" do
    def si(s) = Prick::Inflector.singularize(s)

    it "singularizes a word" do
      expect(si "dogs").to eq "dog"
    end

    it "handles 's'" do
      expect(si "s").to eq "s"
    end

    context "when word is uncountable" do
      it "handles -es suffix" do
        expect(si "newses").to eq "news"
      end
      it "handles -s suffix" do
        expect(si "sheeps").to eq "sheep"
      end
    end
  end

  describe "#self.plural?" do
    def pl(s) = Prick::Inflector.plural?(s)

    it "returns true if the word is plural" do
      expect(pl "dogs").to eq true
      expect(pl "dog").to eq false
    end

    context "when the word is uncountable" do
      it "handles -es suffix" do
        expect(pl "news").to eq false
        expect(pl "newses").to eq true
      end

      it "handles -s suffix" do
        expect(pl "sheep").to eq false
        expect(pl "sheeps").to eq true
      end
    end
  end

  describe "#self.plural?" do
    def si(s) = Prick::Inflector.singular?(s)

    it "returns true if the word is singular" do
      expect(si "dogs").to eq false
      expect(si "dog").to eq true
    end

    context "when the word is uncountable" do
      it "handles -es suffix" do
        expect(si "news").to eq true
        expect(si "newses").to eq false
      end

      it "handles -s suffix" do
        expect(si "sheep").to eq true
        expect(si "sheeps").to eq false
      end
    end
  end
end

describe String::Prick::Inflector do
  using String::Prick::Inflector
  it "extends String" do
    expect("dog".pluralize).to eq "dogs"
    expect("dogs".singularize).to eq "dog"
    expect("dog".plural?).to eq false
    expect("dog".singular?).to eq true
  end
end















