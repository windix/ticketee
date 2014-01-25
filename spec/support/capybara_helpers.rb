module CapybaraHelpers
  def assert_link_for(text)
    expect(page).to have_css("a", :text => text), "Expected to see the #{text.inspect} link, but did not."
  end

  def assert_no_link_for(text)
    expect(page).not_to have_css("a", :text => text), "Expected not to see the #{text.inspect} link, but did."
  end
end

RSpec.configure do |c|
  c.include CapybaraHelpers, type: :feature
end