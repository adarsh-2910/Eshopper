class WishlistController < ApplicationController
    def index
    @wish = current_user.user_wishlists.all   
        
    end    

    def create
        user_id =  current_user.id
        product = Product.find(params[:id])
        if product.user_wishlists.present? && current_user.user_wishlists.present?
            redirect_to request.referrer, notice: "already in wishlist"   #products_wishlist_path
        else
        wishlist = UserWishlist.create(user_id: user_id , product_id: product.id) 
        if wishlist.save
            redirect_to request.referrer,  notice: "item  added successfully in wishlist"
        end
        end
    end
    
    def destroy
        user_id =  current_user.id
        product = Product.find(params[:id])
        @user_wishlist = UserWishlist.find_by(product_id: product.id)
        if @user_wishlist.destroy
        redirect_to wishlist_index_path, notice: "item successfully removed from wishlist"
        else
        redirect_to wishlist_index_path, notice: "failed to remove from wishilst"
        end
    end       
end
