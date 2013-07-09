Bookmarks [![Build Status](https://travis-ci.org/lkdjiin/bookmarks.png)](https://travis-ci.org/lkdjiin/bookmarks) [![Gem Version](https://badge.fury.io/rb/bookmarks.png)](http://badge.fury.io/rb/bookmarks)
================

Description
-----------

Bookmarks is a library to parse or build a file of bookmarks, currently
only files in netscape format, like the ones exported by Delicious.

Install
-------------------------

On the CLI

    gem install bookmarks

or in a Gemfile

    gem 'bookmarks'

Usage
--------------------------

    require 'bookmarks'

    # To parse a document.
    document = Document.new
    document.parse 'bookmarks_file.html'
    document.total # => Number of bookmarks.
    first_bookmark = document.bookmarks.first
    first_bookmark.class # => NetscapeBookmark
    first_bookmark.url # => Url of the bookmark.
    first_bookmark.title # => Title of the bookmark.
    first_bookmark.tags # => Tags of the bookmark.
    first_bookmark.date # => Date of the bookmark.
    first_bookmark.description # => Description of the bookmark.

    # To build a document.
    # ary is an array of NetscapeBookmark.
    document.build do
      ary.each {|e| e }
    end
    


Dependencies
--------------------------

  * ruby >= 2.0.0

Contributing
-------------------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


License
--------------------------

MIT


Questions and/or Comments
--------------------------

Feel free to email [Xavier Nayrac](mailto:xavier.nayrac@gmail.com)
with any questions, or contact me on [twitter](https://twitter.com/lkdjiin).
