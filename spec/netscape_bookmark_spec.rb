require './spec/helper'

describe NetscapeBookmark do
  before { @object = NetscapeBookmark.new }
  subject { @object }

  it { is_expected.to respond_to(:url) }
  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:date) }
  it { is_expected.to respond_to(:tags) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:to_s) }

  describe '#url' do
    subject { super().url }
    it { is_expected.to be_empty }
  end

  describe '#title' do
    subject { super().title }
    it { is_expected.to be_empty }
  end

  describe '#date' do
    subject { super().date }
    it { is_expected.to be_nil }
  end

  describe '#tags' do
    subject { super().tags }
    it { is_expected.to be_empty }
  end

  describe '#description' do
    subject { super().description }
    it { is_expected.to be_empty }
  end

  describe '#to_s' do
    subject { super().to_s }
    it { is_expected.to eq '<DT><A HREF="" ADD_DATE="" TAGS="">None</A>' }
  end

  describe "when initialized with arguments" do
    before do
      @object = NetscapeBookmark.new url: "http://example.com", title: "title"
    end

    describe '#url' do
      subject { super().url }
      it { is_expected.to eq "http://example.com" }
    end

    describe '#title' do
      subject { super().title }
      it { is_expected.to eq "title" }
    end

    describe '#date' do
      subject { super().date }
      it { is_expected.to be_nil }
    end

    describe '#tags' do
      subject { super().tags }
      it { is_expected.to be_empty }
    end

    describe '#description' do
      subject { super().description }
      it { is_expected.to be_empty }
    end
  end

  describe "#url" do
    before { @object.url = "http://example.com" }

    describe '#url' do
      subject { super().url }
      it { is_expected.to eq "http://example.com" }
    end
  end

  describe "#title" do
    before { @object.title = "title" }

    describe '#title' do
      subject { super().title }
      it { is_expected.to eq "title" }
    end
  end

  describe "#date" do
    it "should set the date" do
      date = DateTime.now
      @object.date = date
      expect(@object.date).to eq(date)
    end
  end

  describe "#tags" do
    before { @object.tags = "t1,t2" }

    describe '#tags' do
      subject { super().tags }
      it { is_expected.to eq "t1,t2" }
    end
  end

  describe "#add_tags" do
    describe "starting with some tags" do
      before { @object.tags = "t1,t2" }

      describe "add a single tag" do
        before { @object.add_tags ["t3"] }

        describe '#tags' do
          subject { super().tags }
          it { is_expected.to eq "t1,t2,t3" }
        end
      end

      describe "add some tags" do
        before { @object.add_tags ["t3", "t4"] }

        describe '#tags' do
          subject { super().tags }
          it { is_expected.to eq "t1,t2,t3,t4" }
        end
      end
    end

    describe "starting with no tags" do
      before { @object.tags = "" }

      describe "add a single tag" do
        before { @object.add_tags ["t3"] }

        describe '#tags' do
          subject { super().tags }
          it { is_expected.to eq "t3" }
        end
      end

      describe "add some tags" do
        before { @object.add_tags ["t3", "t4"] }

        describe '#tags' do
          subject { super().tags }
          it { is_expected.to eq "t3,t4" }
        end
      end
    end
  end

  describe "#description" do
    before { @object.description = "description" }

    describe '#description' do
      subject { super().description }
      it { is_expected.to eq "description" }
    end
  end

end
