module Bookmarks

  # Public: A single bookmark in netscape format.
  #
  # REVIEW Should we extract some of the class methods?
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

    # Public: Add some tags to this bookmark.
    #
    # list - An Array of String tags.
    #
    # Returns nothing.
    def add_tags list
      unless @tags.empty?
        @tags += ','
      end
      @tags += list.join(',')
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

    # Public: Initialize a new NetscapeBookmark object from a line from
    # a bookmarks file.
    #
    # line - String line from a bookmarks file.
    #
    # Returns a new NetscapeBookmark object.
    def self.from_string line
      url = /HREF="(.*?)"/.match(line)[1]
      title = /HREF=.*>(.*)<\/A>$/.match(line)[1]
      date = /ADD_DATE="(.*?)"/.match(line)[1]
      date = Time.at(date.to_i).to_s
      tags = self.extract_tags(line)
      title = prettify_title title, url
      new url: url, title: title, date: date, tags: tags
    end

    # Public: Get tags from a line from a bookmarks file.
    #
    # line - String line from a bookmarks file.
    #
    # Returns a String with tags or an empty string.
    def self.extract_tags line
      md = /TAGS="(.*?)"/.match(line)
      md ? md[1] : ""
    end

    # In some case (which?) Delicious miss the title and we have a crapy
    # 'None' instead of the original title. Bad news is the original title
    # is lost. And there is no good news :) In such case, we build a new
    # title from the url.
    #
    # Examples
    #
    #   # Before expand_title
    #   @title # => 'None'
    #   @url   # => "http://designmodo.com/flat-design-colors/"
    #   # After expand_title
    #   @title # => 'flat design colors'
    #
    # Returns String prettified title.
    def self.prettify_title title, url
      return title unless title == '' || title == 'None'
      title = url
      # Remove '/' at the end if it exists.
      title = title.gsub(/\/$/, '')
      # Keep the last element of the url.
      title = title.match(/^.*\/(.*)/)[1]
      # Substitute each '-' by a space.
      title = title.gsub('-', ' ')
    end

  end
end
