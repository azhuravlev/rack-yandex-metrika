require 'helper'

class TestRackYandexMetrika < Test::Unit::TestCase

  context "Asyncronous" do
    context "default" do
      setup { mock_app :async => true, :counter_id => 111 }
      should "show asyncronous tracker" do
        get "/"
        assert_match %r{\.push\(function\(\)}, last_response.body
        assert_match %r{w\.yaCounter111}, last_response.body
        assert_match %r{</script></head><body>}, last_response.body
        assert_equal "795", last_response.headers['Content-Length']
      end

      should "not add tracker to non-html content-type" do
        get "/test.xml"
        assert_no_match %r{yaCounter}, last_response.body
        assert_match %r{Xml here}, last_response.body
      end

      should "not add without </head>" do
        get "/body"
        assert_no_match %r{yaCounter}, last_response.body
        assert_match %r{bob here}, last_response.body
      end
    end

    context "webvisor" do
      setup { mock_app :async => true, :counter_id => 111, :webvisor => true }
      should "add webvisor support" do
        get "/"
        assert_match %r{webvisor:true}, last_response.body
        assert_equal "810", last_response.headers['Content-Length']
      end
    end

    context "clickmap" do
      setup { mock_app :async => true, :counter_id => 111, :clickmap => true }
      should "add clickmap support" do
        get "/"
        assert_match %r{clickmap:true}, last_response.body
        assert_equal "810", last_response.headers['Content-Length']
      end
    end

    context "trackLinks" do
      setup { mock_app :async => true, :counter_id => 111, :trackLinks => true }
      should "add trackLinks support" do
        get "/"
        assert_match %r{trackLinks:true}, last_response.body
        assert_equal "812", last_response.headers['Content-Length']
      end
    end

    context "accurateTrackBounce" do
      setup { mock_app :async => true, :counter_id => 111, :accurateTrackBounce => true }
      should "add accurateTrackBounce support" do
        get "/"
        assert_match %r{accurateTrackBounce:true}, last_response.body
        assert_equal "821", last_response.headers['Content-Length']
      end
    end

    context "trackHash" do
      setup { mock_app :async => true, :counter_id => 111, :trackHash => true }
      should "add trackHash support" do
        get "/"
        assert_match %r{trackHash:true}, last_response.body
        assert_equal "811", last_response.headers['Content-Length']
      end
    end
  end

  context "Syncronous" do
    context "default" do
      setup { mock_app :async => false, :counter_id => 222 }
      should "show non-asyncronous tracker" do
        get "/"
        assert_match %r{var yaCounter222}, last_response.body
        assert_match %r{</noscript>\n</body>}, last_response.body
        assert_equal "790", last_response.headers['Content-Length']
      end
    end

    context "webvisor" do
      setup { mock_app :async => false, :counter_id => 222, :webvisor => true }
      should "add webvisor support" do
        get "/"
        assert_match %r{webvisor:true}, last_response.body
        assert_equal "805", last_response.headers['Content-Length']
      end
    end

    context "clickmap" do
      setup { mock_app :async => false, :counter_id => 222, :clickmap => true }
      should "add clickmap support" do
        get "/"
        assert_match %r{clickmap:true}, last_response.body
        assert_equal "805", last_response.headers['Content-Length']
      end
    end

    context "trackLinks" do
      setup { mock_app :async => false, :counter_id => 222, :trackLinks => true }
      should "add trackLinks support" do
        get "/"
        assert_match %r{trackLinks:true}, last_response.body
        assert_equal "807", last_response.headers['Content-Length']
      end
    end

    context "accurateTrackBounce" do
      setup { mock_app :async => false, :counter_id => 222, :accurateTrackBounce => true }
      should "add accurateTrackBounce support" do
        get "/"
        assert_match %r{accurateTrackBounce:true}, last_response.body
        assert_equal "816", last_response.headers['Content-Length']
      end
    end

    context "trackHash" do
      setup { mock_app :async => false, :counter_id => 222, :trackHash => true }
      should "add trackHash support" do
        get "/"
        assert_match %r{trackHash:true}, last_response.body
        assert_equal "806", last_response.headers['Content-Length']
      end
    end
  end

end
