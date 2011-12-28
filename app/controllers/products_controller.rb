class ProductsController < ApplicationController
before_filter :authenticate
  # GET /products
  # GET /products.json
  def index
    if params[:search]
    	if (params[:search].length>0)
    		@products = Product.with_query(params[:search]).paginate(:page => params[:page])
    	else
    		@products = current_user.products.all.paginate(:page => params[:page])
    	end
    else
    	@products = current_user.products.all.paginate(:page => params[:page])
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
	@segments = Commodity.find_by_sql("select DISTINCT segment_id, segment_title from commodities  ORDER BY SEGMENT_TITLE")
    respond_to do |format|
      #format.html { render action: "new"}
      format.html {render :layout => 'fancyform'}
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
    @product.user_id=current_user.id
	@title="products"
	@validatedDuplicates=params[:validated_duplicates]
	if @validatedDuplicates!="on"
		@products=Product.with_query(@product.manufacturer+' '+@product.name+' '+@product.description).paginate(:page => params[:page])
		if @products.length==0
			@validatedDuplicates="on"
		end
	end

	respond_to do |format|
		if @validatedDuplicates!="on"
			format.js {render :content_type => 'text/javascript'}
			format.html { render action: "new" }
        	format.json { render json: @product.errors, status: :Duplicates }
		else
			if @product.save
				format.js {render :content_type => 'text/javascript'}
        		format.html { redirect_to @product, notice: 'Product was successfully created.'}
        		format.json { render json: @product, status: :created, location: @product }
      		else
        		format.js {render :content_type => 'text/javascript'}
        		format.html { render action: "new" }
        		format.json { render json: @product.errors, status: :unprocessable_entity }
     		end
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

	def update_segment_select
	@families=Commodity.find_by_sql("select DISTINCT family_id, family_title from commodities WHERE SEGMENT_ID='"+params[:id]+"' ORDER BY family_TITLE")
		respond_to do |format|
			format.js {render :content_type => 'text/javascript'}
		end
	end
	def update_family_select
	@classes=Commodity.find_by_sql("select DISTINCT class_id, class_title from commodities WHERE FAMILY_ID='"+params[:id]+"' ORDER BY CLASS_TITLE")
		respond_to do |format|
			format.js {render :content_type => 'text/javascript'}
		end
	end
	def update_class_select
	@commodities=Commodity.find_by_sql("select DISTINCT id, title from commodities WHERE CLASS_ID='"+params[:id]+"' ORDER BY TITLE")
		respond_to do |format|
			format.js {render :content_type => 'text/javascript'}
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
