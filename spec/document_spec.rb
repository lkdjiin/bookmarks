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
      document = @object.build do
        ary.each {|e| e}
      end
      document.should == fixture_file('empty_netscape_file.html')
    end

    it "should build a bookmarks file" do
      ary = array_of_bookmarks
      document = @object.build do
        ary.each {|e| e}
      end
      document.should == fixture_file('mini_netscape_file.html')
    end

    describe "document is always available" do
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

    it "should parse a empty bookmarks file" do
      @object.parse fixture_file_path('empty_netscape_file.html')
      @object.bookmarks.should == []
    end

    describe "with a valid bookmarks file" do
      before do
        @object.parse fixture_file_path('mini_netscape_file.html')
      end

      describe "first bookmark" do
        subject { @object.bookmarks.first }
        its(:url) { should eq "http://example1.com" }
        its(:title) { should eq "title 1" }
        its(:date) { should eq "2001-02-03 01:00:00 +0100" }
        its(:tags) { should eq "t1,t2" }
        its(:description) { should eq "description" }
      end

      describe "second bookmark" do
        subject { @object.bookmarks.last }
        its(:url) { should eq "http://example2.com" }
        its(:title) { should eq "title 2" }
        its(:date) { should eq "2001-02-03 01:00:00 +0100" }
        its(:tags) { should eq "" }
        its(:description) { should eq "" }
      end
    end

    describe "with a bookmarks file containing 'None' titles" do
      before do
        @object.parse fixture_file_path('none_titles_netscape_file.html')
      end

      describe "first bookmark" do
        subject { @object.bookmarks.first }
        its(:title) { should eq "example.com" }
      end

      describe "second bookmark" do
        subject { @object.bookmarks[1] }
        its(:title) { should eq "title" }
      end

      describe "third bookmark" do
        subject { @object.bookmarks[2] }
        its(:title) { should eq "title subtitle" }
      end

      describe "fourth bookmark" do
        subject { @object.bookmarks[3] }
        its(:title) { should eq "title.html" }
      end

    end

  end

end
