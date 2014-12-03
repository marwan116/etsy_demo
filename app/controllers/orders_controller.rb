class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @orders = Order.all.order("created_at DESC")
  end

  def show
  end

  def new
    @order = Order.new
    @Listing=Listing.find(params[:listing_id])

  end

  def edit
  end

  def create
    @order = Order.new(order_params)
    @listing=Listing.find(params[:listing_id])
    @seller= @listing.user

    @order.listing_id=@listing.id
    @order.buyer_id= current_user.id
    @order.seller_id= @seller.id

    respond_to do |format|
      if @order.save
        format.html { redirect_to root_url, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
   respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

 def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to order_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:address, :city, :state)
    end
end
