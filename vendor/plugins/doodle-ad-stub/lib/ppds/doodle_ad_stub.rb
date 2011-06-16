module Ppds # :nodoc:

  class DoodleAdStub

    cattr_accessor :client_id, :language

  end

  module DoodleAdStubHelper

    def in_production?
      (RAILS_ENV == 'production' and not DoodleAdStub.client_id.blank?)
    end

    def stub_image
      image = "#{@ad_width}x#{@ad_height}_text.png"
      image_url = "/images/doodle_ad_stub/#{image}"
      image_path = File.join(RAILS_ROOT, "public", image_url)
      return "Stub image #{image} not found!" unless File.exists?(image_path)
      "<img src=\"#{image_url}\" alt=\"#{image}\" />"
    end

    def js_code
      return stub_image unless in_production?
      g = DoodleAdStub.new
      js = "<script type=\"text/javascript\"><!--\n"
      js << "google_ad_client = '#{g.client_id}';\n"
      js << "google_ad_slot = '#{@ad_slot}';\n"
      js << "google_ad_width = #{@ad_width};\n"
      js << "google_ad_height = #{@ad_height};\n"
      js << "//-->\n"
      js << "</script>\n"
      js << "<script type=\"text/javascript\" src=\"http://pagead2.googlesyndication.com/pagead/show_ads.js\" type=\"text/javascript\"></script>\n"
      js

    end

    def google_ad(ad_width, ad_height, ad_slot)
      @ad_width  = ad_width
      @ad_height = ad_height
      @ad_slot   = ad_slot
      "<div class=\"google_adsense ad#{@ad_width}x#{@ad_height}\">\n" + js_code + "</div>\n"
    end

  end

end
