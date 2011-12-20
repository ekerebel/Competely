class ProductsController < ApplicationController
before_filter :authenticate
  # GET /products
  # GET /products.json
  def index
    #@products = Product.all.paginate(:page => params[:page])
    #@products = Product.with_query('apple').paginate(:page => params[:page])
    #@products = current_user.Product.paginate(:page => params[:page])
    if (params[:search].length>0)
    	@products = Product.with_query(params[:search]).paginate(:page => params[:page])
    else
    	@products = Product.all.paginate(:page => params[:page])
    end
    @title="products"
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])
	@title="products"
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new
	@title="products"
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
    @title="products"
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(params[:product])
	@title="products"
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])
	@title="products"
    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :ok }
    end
  end
  def authenticate
      deny_access unless signed_in?
    end
    
	
    
end
