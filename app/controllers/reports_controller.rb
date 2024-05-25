class ReportsController < ApplicationController
  #  def balance
  #    redirect_to root_path, notice: 'Não implementado'
  #  end
  # end
  
    def balance
        UserMailer.balance_report_email(current_user).deliver_later
      redirect_to root_path, notice: 'O relatório foi enviado para seu e-mail.'
    end
  end