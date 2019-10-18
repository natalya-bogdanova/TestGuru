class BadgesByRuleService

  def initialize(test_passage)
    @test_passage = test_passage
    @test = test_passage.test
    @user = test_passage.user
  end

  def reached?
    raise 'Not implemented!'
  end

  def last_same_badge_date(badge)
    last_badge = badge.user_badges.where(user: @user).order(created_at: :desc).last
    last_badge ? last_badge.updated_at : nil
  end

  def passed_user_test(badge)
    date = last_same_badge_date(badge)
    date ? @user.test_passages.by_date(date) : @user.test_passages.success
  end
end
