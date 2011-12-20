class PricesController < ApplicationController
before_filter :authenticate
def create
    @product = Product.find(params[:product_id])
    @price = @product.prices.create(params[:price])
    redirect_to product_path(@product)
  end
  
 def destroy
    @product = Product.find(params[:product_id])
    @price = @product.prices.find(params[:id])
    @price.destroy
    redirect_to product_path(@product)
  end
  def authenticate
      deny_access unless signed_in?
    end
end
