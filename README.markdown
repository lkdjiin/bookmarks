Bookmarks [![Gem Version](https://badge.fury.io/rb/bookmarks.png)](http://badge.fury.io/rb/bookmarks)
================

Description
-----------

Parse or build a file of bookmarks, in the *Netscape Bookmark File Format*.

Install
-------------------------

In Gemfile:

    gem 'bookmarks'

Usage
--------------------------

    require 'bookmarks'

    document = Document.new
    document.parse 'bookmarks_file.html'

    document.total # => Number of bookmarks.

    document.bookmarks.each do |b|
      puts b.url
      puts b.title
      puts b.tags
      puts b.date
      puts b.description
    end

Dependencies
--------------------------

  * ruby >= 2.5.0 (should work with earlier versions)


License
--------------------------

MIT


Questions and/or Comments
--------------------------

Feel free to email [Xavier Nayrac](mailto:xavier.nayrac@gmail.com)
with any questions, or contact me on [twitter](https://twitter.com/lkdjiin).
