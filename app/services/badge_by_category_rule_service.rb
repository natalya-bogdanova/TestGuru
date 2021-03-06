class BadgeByCategoryRuleService < BadgesByRuleService

  def initialize(test_passage, badge)
    super(test_passage)
    @badge = badge
  end

  def reached?
    return false if @badge.rule_value != @test.category.title

    user_passed_tests = passed_user_test(@badge).success.pluck(:test_id)
    needed_tests_for_badge = Test.by_category(@badge.rule_value).ids

    (needed_tests_for_badge - user_passed_tests).empty?
  end
end
