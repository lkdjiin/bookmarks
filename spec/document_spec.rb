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
    expect(object.bookmarks_format).to eq(:netscape)
  end

  describe "with netscape format" do
    before { @object = Document.new format: :netscape }
    subject { @object }

    it { is_expected.to respond_to(:parse) }
    it { is_expected.to respond_to(:build) }
    it { is_expected.to respond_to(:document) }

    describe '#document' do
      subject { super().document }
      it { is_expected.to eq "" }
    end

    describe '#total' do
      subject { super().total }
      it { is_expected.to eq 0 }
    end

    it "should build a 'empty' bookmarks file" do
      ary = []
      document = @object.build do
        ary.each {|e| e}
      end
      expect(document).to eq(fixture_file('empty_netscape_file.html'))
      expect(@object.total).to eq 0
    end

    it "should build a bookmarks file" do
      ary = array_of_bookmarks
      document = @object.build do
        ary.each {|e| e}
      end
      expect(document).to eq(fixture_file('mini_netscape_file.html'))
      expect(@object.total).to eq 2
    end

    describe "document is always available" do
      it "should build a 'empty' bookmarks file" do
        ary = []
        @object.build do
          ary.each {|e| e}
        end
        expect(@object.document).to eq(fixture_file('empty_netscape_file.html'))
      end

      it "should build a bookmarks file" do
        ary = array_of_bookmarks
        @object.build do
          ary.each {|e| e}
        end
        expect(@object.document).to eq(fixture_file('mini_netscape_file.html'))
      end
    end

    it "should parse a empty bookmarks file" do
      @object.parse fixture_file_path('empty_netscape_file.html')
      expect(@object.bookmarks).to eq([])
    end

    describe "with a valid bookmarks file" do
      before do
        @object.parse fixture_file_path('mini_netscape_file.html')
      end

      describe '#total' do
        subject { super().total }
        it { is_expected.to eq 2 }
      end

      describe "first bookmark" do
        subject { @object.bookmarks.first }

        describe '#url' do
          subject { super().url }
          it { is_expected.to eq "http://example1.com" }
        end

        describe '#title' do
          subject { super().title }
          it { is_expected.to eq "title 1" }
        end

        describe '#date' do
          subject { super().date }
          it { is_expected.to start_with "2001-02-03" }
        end

        describe '#tags' do
          subject { super().tags }
          it { is_expected.to eq "t1,t2" }
        end

        describe '#description' do
          subject { super().description }
          it { is_expected.to eq "description" }
        end
      end

      describe "second bookmark" do
        subject { @object.bookmarks.last }

        describe '#url' do
          subject { super().url }
          it { is_expected.to eq "http://example2.com" }
        end

        describe '#title' do
          subject { super().title }
          it { is_expected.to eq "title 2" }
        end

        describe '#date' do
          subject { super().date }
          it { is_expected.to start_with "2001-02-03" }
        end

        describe '#tags' do
          subject { super().tags }
          it { is_expected.to eq "" }
        end

        describe '#description' do
          subject { super().description }
          it { is_expected.to eq "" }
        end
      end
    end

    describe "with a bookmarks file containing 'None' titles" do
      before do
        @object.parse fixture_file_path('none_titles_netscape_file.html')
      end

      describe "first bookmark" do
        subject { @object.bookmarks.first }

        describe '#title' do
          subject { super().title }
          it { is_expected.to eq "example.com" }
        end
      end

      describe "second bookmark" do
        subject { @object.bookmarks[1] }

        describe '#title' do
          subject { super().title }
          it { is_expected.to eq "title" }
        end
      end

      describe "third bookmark" do
        subject { @object.bookmarks[2] }

        describe '#title' do
          subject { super().title }
          it { is_expected.to eq "title subtitle" }
        end
      end

      describe "fourth bookmark" do
        subject { @object.bookmarks[3] }

        describe '#title' do
          subject { super().title }
          it { is_expected.to eq "title.html" }
        end
      end

    end

    describe "with one H3 title" do
      before do
        @object.parse fixture_file_path('ultra_mini_firefox_file.html')
      end

      describe '#total' do
        subject { super().total }
        it { is_expected.to eq 1 }
      end

      describe "first bookmark" do
        subject { @object.bookmarks.first }

        describe '#url' do
          subject { super().url }
          it { is_expected.to eq "http://example1.com" }
        end

        describe '#title' do
          subject { super().title }
          it { is_expected.to eq "title1" }
        end

        describe '#tags' do
          subject { super().tags }
          it { is_expected.to eq "Category1" }
        end

        describe '#description' do
          subject { super().description }
          it { is_expected.to eq "Blabla" }
        end
      end

    end

    describe "with H3 titles as tags" do
      before do
        @object.parse fixture_file_path('mini_firefox_file.html')
      end

      describe '#total' do
        subject { super().total }
        it { is_expected.to eq 4 }
      end

      describe "first bookmark" do
        subject { @object.bookmarks.first }

        describe '#url' do
          subject { super().url }
          it { is_expected.to eq "http://example1.com" }
        end

        describe '#title' do
          subject { super().title }
          it { is_expected.to eq "title1" }
        end

        describe '#tags' do
          subject { super().tags }
          it { is_expected.to eq "Category1" }
        end

        describe '#description' do
          subject { super().description }
          it { is_expected.to eq "" }
        end
      end

      describe "second bookmark" do
        subject { @object.bookmarks[1] }

        describe '#url' do
          subject { super().url }
          it { is_expected.to eq "http://example2.com" }
        end

        describe '#title' do
          subject { super().title }
          it { is_expected.to eq "title2" }
        end

        describe '#tags' do
          subject { super().tags }
          it { is_expected.to eq "Category1" }
        end

        describe '#description' do
          subject { super().description }
          it { is_expected.to eq "Blabla" }
        end
      end

      describe "third bookmark" do
        subject { @object.bookmarks[2] }

        describe '#url' do
          subject { super().url }
          it { is_expected.to eq "http://example3.com" }
        end

        describe '#title' do
          subject { super().title }
          it { is_expected.to eq "title3" }
        end

        describe '#tags' do
          subject { super().tags }
          it { is_expected.to eq "Category2,Foo,Bar" }
        end

        describe '#description' do
          subject { super().description }
          it { is_expected.to eq "" }
        end
      end

      describe "fourth bookmark" do
        subject { @object.bookmarks[3] }

        describe '#url' do
          subject { super().url }
          it { is_expected.to eq "http://example4.com" }
        end

        describe '#title' do
          subject { super().title }
          it { is_expected.to eq "title4" }
        end

        describe '#tags' do
          subject { super().tags }
          it { is_expected.to eq "Category2,Foo,machin" }
        end

        describe '#description' do
          subject { super().description }
          it { is_expected.to eq "" }
        end
      end

    end

    describe "with almost real firefox file" do
      before do
        @object.parse fixture_file_path('almost_real_firefox_file.html')
      end

      describe '#total' do
        subject { super().total }
        it { is_expected.to eq 4 }
      end

      describe "first bookmark" do
        subject { @object.bookmarks.first }

        describe '#url' do
          subject { super().url }
          it { is_expected.to eq "http://example1.com" }
        end

        describe '#title' do
          subject { super().title }
          it { is_expected.to eq "title1" }
        end

        describe '#tags' do
          subject { super().tags }
          it { is_expected.to eq "Category1" }
        end

        describe '#description' do
          subject { super().description }
          it { is_expected.to eq "Blabla" }
        end
      end

      describe "second bookmark" do
        subject { @object.bookmarks[1] }

        describe '#url' do
          subject { super().url }
          it { is_expected.to eq "http://example2.com" }
        end

        describe '#title' do
          subject { super().title }
          it { is_expected.to eq "title2" }
        end

        describe '#tags' do
          subject { super().tags }
          it { is_expected.to eq "Category1" }
        end

        describe '#description' do
          subject { super().description }
          it { is_expected.to eq "" }
        end
      end

      describe "third bookmark" do
        subject { @object.bookmarks[2] }

        describe '#url' do
          subject { super().url }
          it { is_expected.to eq "http://example3.com" }
        end

        describe '#title' do
          subject { super().title }
          it { is_expected.to eq "title3" }
        end

        describe '#tags' do
          subject { super().tags }
          it { is_expected.to eq "Category2,Foo,Bar" }
        end

        describe '#description' do
          subject { super().description }
          it { is_expected.to eq "" }
        end
      end

      describe "fourth bookmark" do
        subject { @object.bookmarks[3] }

        describe '#url' do
          subject { super().url }
          it { is_expected.to eq "http://example4.com" }
        end

        describe '#title' do
          subject { super().title }
          it { is_expected.to eq "title4" }
        end

        describe '#tags' do
          subject { super().tags }
          it { is_expected.to eq "Category2,Foo,machin" }
        end

        describe '#description' do
          subject { super().description }
          it { is_expected.to eq "" }
        end
      end
    end

    context "with html entities in H3" do
      before { @object.parse fixture_file_path('html_entities_in_h3.html') }

      describe "third bookmark" do
        subject { @object.bookmarks[2] }

        describe '#tags' do
          subject { super().tags }
          it { is_expected.to eq "Category2,Liens d'Ubuntu,Bar" }
        end
      end
    end

    describe "with more than http href" do
      before do
        @object.parse fixture_file_path('not_just_http_file.html')
      end

      describe '#total' do
        subject { super().total }
        it { is_expected.to eq 2 }
      end

      describe "first bookmark" do
        subject { @object.bookmarks.first }

        describe '#url' do
          subject { super().url }
          it { is_expected.to eq "http://example1.com" }
        end

        describe '#title' do
          subject { super().title }
          it { is_expected.to eq "title1" }
        end

        describe '#tags' do
          subject { super().tags }
          it { is_expected.to eq "Category1" }
        end

        describe '#description' do
          subject { super().description }
          it { is_expected.to eq "Blabla" }
        end
      end

      describe "second bookmark" do
        subject { @object.bookmarks[1] }

        describe '#url' do
          subject { super().url }
          it { is_expected.to eq "http://example3.com" }
        end

        describe '#title' do
          subject { super().title }
          it { is_expected.to eq "title3" }
        end

        describe '#tags' do
          subject { super().tags }
          it { is_expected.to eq "Category1" }
        end

        describe '#description' do
          subject { super().description }
          it { is_expected.to eq "" }
        end
      end

    end
  end

end
