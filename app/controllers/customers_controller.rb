class CustomersController < ApplicationController
  before_action :logged_in_customer,only: [:edit,:update]
  before_action :correct_customer,only: [:edit,:update]
  before_action :admin_user,only: [:destroy]

  def show
  	@customer = Customer.find(params[:id])

  end

  def new	
  	@customer=Customer.new
  
  end

  def create

  	@customer=Customer.new(customer_params)
  	if @customer.save #handle successful save
      log_in @customer
      flash[:success]="Welcome to XYZ Hotels"
      redirect_to @customer
  	else
  		render 'new'
  	end

  end

  def edit
        @customer=Customer.find(params[:id])
       
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update_attributes(customer_params)
      # Handle a successful update.
      flash[:success]="Profile Updated"
      redirect_to @customer
    else
      render 'edit'
    end
  end

  def index
    @customers=Customer.paginate(page: params[:page])
    
  end

  def logged_in_customer
    unless logged_in?
      flash[:danger]="Please log in"
      redirect_to login_url
    end
  end

  def correct_customer
    @customer=Customer.find(params[:id])
    redirect_to root_url unless @customer==current_customer
      
      end
  def destroy
    @customer=Customer.find(params[:id])
    @customer.destroy
    flash[:success]="Customer deleted"
    redirect_to customers_url
  end

  def admin_user
    redirect_to root_url unless current_customer.admin?
  end
  	private

  		def customer_params
  			params.require(:customer).permit(:name,:email,:password,:password_confirmation)
  		end
  	
end    


