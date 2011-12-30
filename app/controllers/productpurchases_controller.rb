class ProductpurchasesController < ApplicationController
def create
    @product = Product.find(params[:product_id])
    @productpurchase = @product.productpurchases.create(params[:productpurchase])
    @userpoint=User.find(@productpurchase.user_id).userpoints.all[0]
    @userpoint.points=@userpoint.points-@product.price()
    @userpoint.save
    respond_to do |format|
		if @product.save
			format.js {render :content_type => 'text/javascript'}
		else
			format.js {render :content_type => 'text/javascript'}
		end
	end
end
end
