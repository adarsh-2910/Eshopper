class UserWishListController < ApplicationController
  
  def new
    puts"i m in new method"
    user_id =  current_user.id
    puts params
    product_id = params[:id]
    puts "product_id----------#{product_id}"
    puts "user_id---------------#{user_id}"
    wishlist = UserWishlist.create(user_id: user_id, product_id: product_id)
    if wishlist.save
      redirect_to root_path, :
    else

    end
    puts "wishlist-------------------#{wishlist.inspect}"
  end  
    
  def create
  end
    
  def destroy
    product = params[:id].to_i
    @wishlist = current_user.user_wishlist
    @product_id = @wishlist.product_id
    @product_id.delete(product)
    @wishlist.save
    redirect_to user_wishlist_path(@wishlist), notice: "item removed from wishlist"
  end
end
