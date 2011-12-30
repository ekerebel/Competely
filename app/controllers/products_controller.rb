class ProductsController < ApplicationController
before_filter :authenticate
  # GET /products
  # GET /products.json
  def index
    @categories = Category.find_by_sql("select id, title from categories where category_type='segment' order by title")
    exp1=""
    if params[:search_category_id] && params[:search_category_id]!="0"
    	minCategory=params[:search_category_id].reverse!.to_i.to_s.reverse!.to_i
    	maxCategory=minCategory+1
    	multiplier=1
    	if minCategory.to_s.length==2
    		multiplier=1000000
    	elsif minCategory.to_s.length==4
    		multiplier=10000
    	elsif minCategory.to_s.length==6
    		multiplier=100
    	end
    	minCategory=minCategory*multiplier
    	maxCategory=maxCategory*multiplier
    	exp1="category_id>="+minCategory.to_s+" AND category_id<"+maxCategory.to_s
    end
    if params[:search]
    	if (params[:search].length>0)
    		@products = Product.with_query(params[:search]).find(:all, :conditions => [exp1]).paginate(:page => params[:page])
    	else
    		@products = Product.find(:all, :conditions => [exp1]).paginate(:page => params[:page])
    	end
    else
    	@products = Product.find(:all, :conditions => [exp1]).paginate(:page => params[:page])
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
	@categories = Category.find_by_sql("select id, title from categories where category_type='segment' order by title")
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
    @categories = Category.find_by_sql("select id, title from categories where category_type='segment' order by title")
     respond_to do |format|
      #format.html { render action: "new"}
      format.html {render :layout => 'fancyform'}
      format.json { render json: @product }
    end
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
      	format.js {render :content_type => 'text/javascript'}
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :ok }
      else
      	format.js {render :content_type => 'text/javascript'}
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

	def update_category_select
	@categories = Category.find_by_sql("select id, title from categories where category_type='"+params[:type]+"' AND parent='"+params[:id]+"' order by title")
    	respond_to do |format|
			format.js {render :content_type => 'text/javascript'}
		end
	end
	
	def follow
		@product = Product.find(params[:id])
    	respond_to do |format|
    		#format.html { render action: "purchase"}
      		format.html {render :layout => 'fancyform'}
      		#format.json { render json: @product }
    	end
	end
	
	def purchase
		@product = Product.find(params[:id])
    	@title="products"
    	respond_to do |format|
    		format.js {render :content_type => 'text/javascript'}
      		#format.html { render action: "new"}
      		#format.html {render :layout => 'fancyform'}
      		#format.json { render json: @product }
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
