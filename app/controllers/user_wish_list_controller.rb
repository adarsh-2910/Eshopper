class UserWishListController < ApplicationController
  
  def new 
    user_id =  current_user.id
    product_id = Product.find(params[:id])
    # binding.pry
    if UserWishlist.where(product_id: product_id.id).present?
        redirect_to welcome_wishlist_path, notice: "item already added to wishlist"
    else
        @user_wishlist = UserWishlist.find_or_create_by(product_id: product_id.id, user_id: user_id)
        @user_wishlist.save
        redirect_to root_path, notice: "item successfully added to wishlist"
    end
  end
    
  def create
  end

  def index
   @wish = current_user.user_wishlists.all
  end  

  def remove_wishlist
    # binding.pry
    # puts "i m in remove wishlist********************************************"
    user_id =  current_user.id
    product_id = params[:id]
    product = Product.find(params[:id])
    # binding.pry
    @user_wishlist = UserWishlist.find_by(product_id: product_id, user_id: user_id)
    if @user_wishlist.destroy
      redirect_to products_wishlist_path, notice: "item successfully removed from wishlist"
    else
      redirect_to root_path, notice: "failed to remove from wishilst"
    end
 end
end