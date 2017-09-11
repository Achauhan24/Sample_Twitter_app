class CustomersController < ApplicationController
  def show
  	@customer = Customer.find(params[:id])

  end

  def new	
  	@customer=Customer.new
  
  end

  def create

  	@customer=Customer.new(customer_params)
  	if @customer.save
      flash[:success]="Welcome to XYZ Hotels"
      redirect_to @customer
  	else
  		render 'new'
  	end


  end


  	private

  		def customer_params
  			params.require(:customer).permit(:name,:email,:password,:password_confirmation)
  		end
  	


end