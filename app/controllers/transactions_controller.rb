class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transaction, only: %i[show edit update destroy]

  # GET /transactions
  # GET /transactions.json
  def index
    # @transactions = Transaction.all.order(created_at: :desc)
    # @transactions = current_user.transactions.order(created_at: :desc)
    # @total_sum = @transactions.sum(:amount)

    @user_transactions = Transaction.int_display(current_user.id).order(created_at: :desc)
    @transaction_sum = @user_transactions.sum(:amount)
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show; end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit; end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user_id = current_user.id

    respond_to do |format|
      if @transaction.save
        if @transaction.group_id.nil?
          format.html { redirect_to '/etransactions', notice: 'Expense was successfully created.' }
        else
          format.html { redirect_to '/transactions', notice: 'Expense was successfully created.' }
        end
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to '/transactions', notice: 'Transaction was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    no_category = @transaction.group_id.nil?
    @transaction.destroy

    if no_category
      respond_to do |format|
        format.html { redirect_to '/etransactions', notice: 'Expense was successfully destroyed.' }
      end
    else
      respond_to do |format|
        format.html { redirect_to transactions_url, notice: 'Expense was successfully destroyed.' }
      end
    end
  end

  def etransaction
    @ext_user_transaction = Transaction.ext_display(current_user).order(created_at: :desc)
    @ext_transaction_sum = @ext_user_transaction.sum(:amount)
  end

  def members_transactions
    @members = Transaction.by_user
    @members_sum = Transaction.all.sum(:amount)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction).permit(:name, :amount, :group_id)
  end
end
