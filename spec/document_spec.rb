# -*- encoding: utf-8 -*-

require './spec/helper'

def array_of_bookmarks
  [
    NetscapeBookmark.new(url: "http://example1.com",
                         title: "title 1",
                         date: DateTime.new(2001,2,3),
                         tags: "t1,t2",
                         description: "description"),
    NetscapeBookmark.new(url: "http://example2.com",
                         title: "title 2",
                         date: DateTime.new(2001,2,3))
  ]
end

describe Document do

  it "should have netscape as default format" do
    object = Document.new
    object.bookmarks_format.should == :netscape
  end

  describe "with netscape format" do
    before { @object = Document.new format: :netscape }
    subject { @object }

    it { should respond_to(:parse) }
    it { should respond_to(:build) }
    it { should respond_to(:document) }
    its(:document) { should eq "" }

    it "should build a 'empty' bookmarks file" do
      ary = []
      @object.build do
        ary.each {|e| e}
      end
      @object.document.should == fixture_file('empty_netscape_file.html')
    end

    it "should build a bookmarks file" do
      ary = array_of_bookmarks
      @object.build do
        ary.each {|e| e}
      end
      @object.document.should == fixture_file('mini_netscape_file.html')
    end
  end
end
