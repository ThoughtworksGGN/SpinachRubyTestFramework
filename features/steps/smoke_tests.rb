class Spinach::Features::SmokeTests < Spinach::FeatureSteps
  include WaitSteps

  step 'I access Yahoo search page' do
    home_page = Pages::Home.new
    Pages::Home.visit
    expect{ home_page.current_page? }.to become_true
  end

  step 'I search for ThoughtWorks' do
    home_page = Pages::Home.new
    expect{ home_page.search_field }.to become_true
    home_page.search("Thoughtworks")
  end

  step 'I submit search' do
    home_page = Pages::Home.new
    home_page.submit_search
  end

  step 'I should see first link as ThoughtWorks' do
    home_page = Pages::Home.new
    expect{ home_page.search_results.count }.to greater_than(0)
    expect{ home_page.link_number(1) }.to include_text("ThoughtWorks")
  end
end
