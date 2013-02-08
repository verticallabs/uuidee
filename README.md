Uuidee
======

Forked from https://github.com/spectra/ruby-uuid, all credit to Pablo Lorenzoni/Shyouhei Urabe.

Created Uuidee just to make including it in gems easier.

Original README from spectra (Pablo Lorenzoni)
----------------------------------------------

I needed a uuid generator for Ruby. There's nothing wrong with current
implementations, I just wanted a simpler one, bundled in a single file (rather
than a gem), that could comply with RFC4122.

I found this charming one using Ruby Struct by Shyouhei Urabe (aka mput),
which is not online anymore (http://raa.ruby-lang.org/project/ruby-uuid/),
unfortunately. I had it in my HD, so I decided to put it back online.

All the credit really goes to mput. I just added a method to set the version
of UUID, since that was missing in the original code. I also intend to
implement version 2, which is also missing.
