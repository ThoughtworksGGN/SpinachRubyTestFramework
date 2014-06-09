module Pages
  class Base < CapybaraPageObject::Page

    def current_page?
      source.current_url.include? path
    end

  end
end