class Admin::TestsController < Admin::BaseController

  before_action :set_test, only: %w[show edit update destroy start]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  def index
    @tests = Test.all
  end

  def show; end

  def edit; end

  def new
    @test = Test.new
  end

  def create
    @test = Test.new(test_params)
    @test.author = current_user

    if @test.save
      redirect_to admin_test_path(@test)
    else
      render :new
    end
  end

  def update
    if @test.update(test_params)
      redirect_to admin_test_path(@test)
    else
      render :edit
    end
  end

  def destroy
    @test.destroy
    redirect_to admin_tests_path
  end

  def start
    current_user.tests.push(@test)
    redirect_to current_user.test_passage(@test)
  end

  private

  def set_test
    @test = Test.find(params[:id])
  end


  def test_params
    params.require(:test).permit(:title, :category_id, :level)
  end

  def rescue_with_test_not_found
    render plain: 'Test not found'
  end
end
