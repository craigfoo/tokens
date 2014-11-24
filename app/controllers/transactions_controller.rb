class TransactionsController < ApplicationController
  # before_action :set_pin, only: [:show, :edit, :update, :destroy]
  # before_action :authenticate_user!, except: [:index]
  before_action :authenticate_user!, except: [:index]
  before_action :find_user
  
  def index
      @transactions = Transaction.where("initiator = ? or  jokester = ?", @user.id, @user.id).order("created_at DESC").page(params[:page]).per_page(10)
  end

  def show
  end

  def new
    	@transaction = Transaction.new({quantity: 1})
  end

  def edit
  end

  def create
    @transaction = Transaction.new(transaction_params)
  	@joke_user = User.find(@transaction.jokester)
  	@init_user = User.find(current_user.id)
    @transaction.initiator = current_user.id

    if @transaction.take_give == true && @init_user.token_bal < 1
    	redirect_to(new_transaction_path, notice: 'Not enough tokens to give, you need to be funnier.')
    elsif @transaction.take_give == false && @init_user.token_bal < @transaction.quantity || @init_user.token_ratio < 0.25
      redirect_to(new_transaction_path, notice: 'You can only take as many as you have and your ratio needs to be 0.25 or higher!')
    elsif @transaction.valid?
        if @transaction.take_give == true
          @joke_user.token_bal += @transaction.quantity
          @init_user.token_bal -= @transaction.quantity
          @init_user.given += @transaction.quantity
        elsif
          @joke_user.token_bal -= @transaction.quantity
          @init_user.taken += @transaction.quantity
        end
        @init_user.token_ratio = ((@init_user.given.to_f - @init_user.taken.to_f)/@init_user.token_bal).abs
        @joke_user.token_ratio = ((@joke_user.given.to_f - @joke_user.taken.to_f)/@joke_user.token_bal).abs
        @transaction.save
        @joke_user.save
        @init_user.save
      	redirect_to(users_path, notice: 'Token Transaction created successfully')
    else
      	render('new')
    end
  end

  def update

  end

  def destroy
    @transaction = Transaction.find(params[:id]).destroy
    redirect_to(transactions_url, notice: 'Transaction was successfully destroyed!')
  end

  def delete
  	@transaction = Transaction.find(params[:id])
  end

  	private
      def transaction_params
        params.require(:transaction).permit(:quantity, :take_give, :initiator, :jokester, :comment)
      end

      def find_user
        if params[:user_id]
          @user = User.find(params[:user_id])
        end
      end

end
