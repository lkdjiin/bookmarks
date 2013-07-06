# -*- encoding: utf-8 -*-

require './spec/helper'

describe Document do

  it "should have netscape as default format" do
    object = Document.new
    object.format.should == :netscape
  end

  describe "with netscape format" do
    before { @object = Document.new format: :netscape }
    subject { @object }

    it { respond_to?(:parse).should be_true }
    it { respond_to?(:build).should be_true }
  end
end
