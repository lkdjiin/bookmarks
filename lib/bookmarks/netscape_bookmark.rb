# -*- encoding: utf-8 -*-

module Bookmarks

  # Public: A single bookmark in netscape format.
  class NetscapeBookmark

    # Public: Init a new NetscapeBookmark.
    #
    # url         - An optional String url.
    # title       - An optional String title.
    # date        - An optional Date/DateTime date.
    # tags        - An optional String tags. Tags are comma separated.
    # description - An optional String description.
    def initialize url: "", title: "", date: nil, tags: "", description: ""
      @url = url
      @title = title
      @date = date
      @tags = tags
      @description = description
    end

    # Public: Set/get the String url.
    attr_accessor :url

    # Public: Set/get the String title.
    attr_accessor :title

    # Public: Set/get the Date/DateTime date.
    attr_accessor :date

    # Public: Set/get the String tags.
    attr_accessor :tags

    # Public: Set/get the String description.
    attr_accessor :description

    # Public: Returns the bookmark as a String.
    def to_s
      str = "<DT><A HREF=\"#{@url}\" " +
        "ADD_DATE=\"#{@date.nil? ? "" : @date.to_time.to_i}\" " +
        "TAGS=\"#{@tags}\">" +
        (@title.empty? ? 'None' : @title) + "</A>"
      if @description.empty?
        str
      else
        str + "\n<DD>#{@description}"
      end
    end
  end
end
