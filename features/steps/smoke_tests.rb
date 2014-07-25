class Spinach::Features::SmokeTests < Spinach::FeatureSteps
  include WaitSteps
  step 'I access page that have comment form' do
    home_page = Pages::Home.new
    Pages::Home.visit
    expect{ home_page.current_page? }.to become_true
  end

  step 'I enter comment author as Pulkit' do
    home_page = Pages::Home.new
    expect{ home_page.comment_author }.to become_true
    home_page.fill_comment_name("Pulkit")
  end

  step 'I enter commentor email as acbg@fgs.com' do
    home_page = Pages::Home.new
    expect{ home_page.comment_email }.to become_true
    home_page.fill_comment_email("acbg@fgs.com")
  end

  step 'I enter comment' do
    home_page = Pages::Home.new
    expect{ home_page.comment }.to become_true
    home_page.fill_comment("acbg@fgs.com")
    home_page.submit_comment
  end

  step 'I should see my comment is awaiting moderation' do
    home_page = Pages::Home.new
    expect{ home_page.all('.comment-awaiting-moderation').count > 0 || page.text.include?("Duplicate comment detected; it looks as though you’ve already said that!")}.to become_true
  end
end
