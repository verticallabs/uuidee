require 'test/unit'
require 'uuid'

class TC_UUID < Test::Unit::TestCase
  def test_v1
    u1 = UUID.create
    u2 = UUID.create
    assert_not_equal u1, u2
  end

  def test_v1_repeatability
    u1 = UUID.create 1, 2, "345678"
    u2 = UUID.create 1, 2, "345678"
    assert_equal u1, u2
  end

  def test_v3
    u1 = UUID.create_md5 "foo", UUID::NameSpace_DNS
    u2 = UUID.create_md5 "foo", UUID::NameSpace_DNS
    u3 = UUID.create_md5 "foo", UUID::NameSpace_URL
    assert_equal u1, u2
    assert_not_equal u1, u3
  end

  def test_v5
    u1 = UUID.create_sha1 "foo", UUID::NameSpace_DNS
    u2 = UUID.create_sha1 "foo", UUID::NameSpace_DNS
    u3 = UUID.create_sha1 "foo", UUID::NameSpace_URL
    assert_equal u1, u2
    assert_not_equal u1, u3
  end

  def test_v4
    # This test  is not  perfect, because the  random nature of  version 4
    # UUID  it is  not always  true that  the three  objects  below really
    # differ.  But  in real  life it's  enough to say  we're OK  when this
    # passes.
    u1 = UUID.create_random
    u2 = UUID.create_random
    u3 = UUID.create_random
    assert_not_equal u1.raw_bytes, u2.raw_bytes
    assert_not_equal u1.raw_bytes, u3.raw_bytes
    assert_not_equal u2.raw_bytes, u3.raw_bytes
  end

  def test_pack
    u1 = UUID.pack 0x6ba7b810, 0x9dad, 0x11d1, 0x80, 0xb4,
      "\000\300O\3240\310"
    assert_equal UUID::NameSpace_DNS, u1
  end

  def test_unpack
    tl, tm, th, cl, ch, m = UUID::NameSpace_DNS.unpack
    assert_equal 0x6ba7b810, tl
    assert_equal 0x9dad, tm
    assert_equal 0x11d1, th
    assert_equal 0x80, cl
    assert_equal 0xb4, ch
    assert_equal "\000\300O\3240\310", m
  end

  def test_parse
    u1 = UUID.pack 0x6ba7b810, 0x9dad, 0x11d1, 0x80, 0xb4,
      "\000\300O\3240\310"
    u2 = UUID.parse "6ba7b810-9dad-11d1-80b4-00c04fd430c8"
    u3 = UUID.parse "urn:uuid:6ba7b810-9dad-11d1-80b4-00c04fd430c8"
    assert_equal u1, u2
    assert_equal u1, u3
  end

  def test_to_s
    u1 = UUID.parse "6ba7b810-9dad-11d1-80b4-00c04fd430c8"
    assert_equal "6ba7b810-9dad-11d1-80b4-00c04fd430c8", u1.to_s
  end

  def test_to_i
    u1 = UUID.parse "6ba7b810-9dad-11d1-80b4-00c04fd430c8"
    assert_equal 0x6ba7b8109dad11d180b400c04fd430c8, u1.to_i
  end

  def test_version
    u1 = UUID.create_v1
    assert_equal 1, u1.version
    u3 = UUID.create_v3 "foo", UUID::NameSpace_DNS
    assert_equal 3, u3.version
    u4 = UUID.create_v4
    assert_equal 4, u4.version
    u5 = UUID.create_v5 "foo", UUID::NameSpace_DNS
    assert_equal 5, u5.version
  end
end
