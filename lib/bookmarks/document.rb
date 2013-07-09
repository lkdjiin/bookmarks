# -*- encoding: utf-8 -*-

module Bookmarks

  # Public: Document is your main interface to the file of bookmarks
  # (called «document»).
  class Document

    # Public: Returns the Symbol format of the document. Currently
    #   there is only one format available: `:netscape`.
    attr_reader :bookmarks_format

    # Public: Returns the String document.
    attr_reader :document

    # Public: Init a new Document.
    #
    # format - The Symbol format of the document (Optional).
    #
    # Examples:
    #
    #   # The two following calls work the same way.
    #   Document.new
    #   Document.new format: :netscape
    def initialize format: :netscape
      @bookmarks_format = format
      @document = ""
    end

    # Public: Build a document, ie build a file of bookmarks.
    #
    # block - A block that enumerate all NetscapeBookmark to put
    #         into the document.
    #
    # Examples:
    #
    #   # ary is an array of NetscapeBookmark.
    #   document.build do
    #     ary.each {|e| e }
    #   end
    #
    # Returns nothing.
    def build &block
      @document += FIRST_PART
      block.call.each {|n| @document += n.to_s + "\n" }
      @document += LAST_PART
    end

    def parse

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
