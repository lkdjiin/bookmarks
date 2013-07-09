# -*- encoding: utf-8 -*-

module Bookmarks

  # Public: Document is your main interface to the file of bookmarks
  # (called «document»).
  class Document

    # Public: Init a new Document.
    #
    # format - The Symbol format of the document (Optional).
    #
    # Examples
    #
    #   # The two following calls work the same way.
    #   Document.new
    #   Document.new format: :netscape
    def initialize format: :netscape
      @bookmarks_format = format
      @document = ""
      @bookmarks = []
      @total = 0
    end

    # Public: Returns the Symbol format of the document. Currently
    #   there is only one format available: `:netscape`.
    attr_reader :bookmarks_format

    # Public: Returns the String document.
    attr_reader :document

    # Public: Returns an Array of NetscapeBookmark bookmarks.
    attr_reader :bookmarks

    # Public: Returns the Integer numbers of bookmarks in the document.
    attr_reader :total

    # Public: Build a document, ie build a file of bookmarks.
    #
    # block - A block that enumerate all NetscapeBookmark to put
    #         into the document.
    #
    # Examples
    #
    #   # ary is an array of NetscapeBookmark.
    #   document.build do
    #     ary.each {|e| e }
    #   end
    #
    # Returns the String document.
    def build &block
      @document += FIRST_PART
      block.call.each do |n|
        @document += n.to_s + "\n"
        @total += 1
      end
      @document += LAST_PART
    end

    # Public: Parse a file of bookmarks (netscape format). Bookmarks could
    # then be retrieved with #bookmarks.
    #
    # file_path - Full String pathname of the file to parse.
    #
    # Returns the String document (see also #document).
    def parse file_path
      File.new(file_path).readlines.each {|line| parse_a_bookmark line }
      @total = @bookmarks.size
    end

    private

    # Parse a single line from a bookmarks file.
    #
    # line - String.
    #
    # Returns nothing.
    def parse_a_bookmark line
      if line =~ /^<DT>/
        @bookmarks << NetscapeBookmark.from_string(line)
      elsif line =~ /^<DD>/
        @bookmarks.last.description = line[4..-1].chomp
      end
    end


# First part of a bookmark's file in netscape format.
FIRST_PART = <<CODE
<!DOCTYPE NETSCAPE-Bookmark-file-1>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
<!-- This is an automatically generated file.
It will be read and overwritten.
Do Not Edit! -->
<TITLE>Bookmarks</TITLE>
<H1>Bookmarks</H1>
<DL><p>
CODE

# Last part of a bookmark's file in netscape format.
LAST_PART = "</DL><p>\n"

  end

end
