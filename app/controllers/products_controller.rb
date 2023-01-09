class ProductsController < ApplicationController

  def add_to_cart          
    id = params[:id].to_i   #finding product id
    session[:cart] << id unless session[:cart].include?(id)  #adding product to cart unless it is already present in shopping cart
    redirect_to welcome_cart_path
  end

  def remove_from_cart
    id = params[:id].to_i
    session[:cart].delete(id)
    redirect_to welcome_cart_path
  end

  def index
    @products = Product.all
  end

  def add_quantity
    # binding.pry
    @item = Product.find(params[:id])
    @item.quantity += 1
    @item.save

    respond_to do |format|
      format.js { render :layout => false }
    end

  end

  def dec_quantity
    @item = Product.find(params[:id])
    @item.quantity -= 1
    @item.save
    
    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  def wishlist 
    @wish = UserWishlist.all   
  end
  
 
end
