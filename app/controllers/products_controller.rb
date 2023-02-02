class ProductsController < ApplicationController

  def add_to_cart          
    id = params[:id].to_i   #finding product id
    session[:cart] << id unless session[:cart].include?(id)  #adding product to cart unless it is already present in shopping cart
    redirect_to request.referrer, notice: "Product is added to cart"
  end

  def remove_from_cart
    id = params[:id].to_i
    session[:cart].delete(id)
    @product = Product.find(params[:id])
    @product.quantity = 1
    @product.save
    redirect_to welcome_cart_path, notice: "Product removed from the cart"
  end

  def index
    @products = Product.all
  end

  def add_quantity
    @item = Product.find(params[:id])
    
      @item.quantity += 1
      @item.save
      respond_to do |format|
      format.js   
      end
  end

  def dec_quantity
    @item = Product.find(params[:id])
    if @item.quantity < 2
      remove_from_cart
    else
      @item.quantity -= 1
      @item.save
      respond_to do |format|
        format.js { render :layout => false }
      end
    end  
  end

  def wishlist 
  end

  def show
    @feature_products = Product.all rescue nil 
    @category = Category.where(parent_id: nil)  
  end  
end
