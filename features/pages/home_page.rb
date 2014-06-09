module Pages
  class Home < Pages::Base
    path '/'

    def search_field
      source.find('#yschsp')
    end

    def submit_search_button
      source.find('.sbb')
    end

    def search(value)
      search_field.set(value)
    end

    def submit_search
      submit_search_button.click
    end

    def search_results
      source.all('.res a.yschttl')
    end

    def link_number(value)
      search_results[value - 1].text
    end

  end
end