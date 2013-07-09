# -*- encoding: utf-8 -*-

require './spec/helper'

describe NetscapeBookmark do
  before { @object = NetscapeBookmark.new }
  subject { @object }

  it { should respond_to(:url) }
  it { should respond_to(:title) }
  it { should respond_to(:date) }
  it { should respond_to(:tags) }
  it { should respond_to(:description) }
  it { should respond_to(:to_s) }

  its(:url) { should be_empty }
  its(:title) { should be_empty }
  its(:date) { should be_nil }
  its(:tags) { should be_empty }
  its(:description) { should be_empty }
  its(:to_s) { should eq '<DT><A HREF="" ADD_DATE="" TAGS="">None</A>' }

  describe "when initialized with arguments" do
    before do
      @object = NetscapeBookmark.new url: "http://example.com", title: "title"
    end
    its(:url) { should eq "http://example.com" }
    its(:title) { should eq "title" }
    its(:date) { should be_nil }
    its(:tags) { should be_empty }
    its(:description) { should be_empty }
  end

  describe "#url" do
    before { @object.url = "http://example.com" }
    its(:url) { should eq "http://example.com" }
  end

  describe "#title" do
    before { @object.title = "title" }
    its(:title) { should eq "title" }
  end

  describe "#date" do
    it "should set the date" do
      date = DateTime.now
      @object.date = date
      @object.date.should == date
    end
  end

  describe "#tags" do
    before { @object.tags = "t1,t2" }
    its(:tags) { should eq "t1,t2" }
  end

  describe "#description" do
    before { @object.description = "description" }
    its(:description) { should eq "description" }
  end

end
