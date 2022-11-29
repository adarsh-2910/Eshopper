class CategoriesController < ApplicationController
  layout "category"
  before_action :set_category
  def show
      
  end 
  
  private
    def set_category
      @category = Category.find(params[:id]) rescue nil
    end
end
