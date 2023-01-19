class UserWishListController < ApplicationController
  
  def new 
    user_id =  current_user.id
    product = Product.find(params[:id])
    if product.user_wishlists.present? && current_user.user_wishlists.present?
      redirect_to root_path, notice: "already in wishlist"   #products_wishlist_path
    else
    wishlist = UserWishlist.create(user_id: user_id , product_id: product.id) 
    if wishlist.save
      redirect_to root_path,  notice: "item  added successfully in wishlist"
    end
  end
  end
    
  def create
  end

  def index
   @wish = current_user.user_wishlists.all
  end  

  def remove_wishlist
    user_id =  current_user.id
    product_id = params[:id]
    product = Product.find(params[:id])
    @user_wishlist = UserWishlist.find_by(product_id: product.id)
    if @user_wishlist.destroy
      redirect_to products_wishlist_path, notice: "item successfully removed from wishlist"
    else
      redirect_to root_path, notice: "failed to remove from wishilst"
  end
 end
end