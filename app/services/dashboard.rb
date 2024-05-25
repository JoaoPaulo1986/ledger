class Dashboard
  def initialize(user)
    @user = user
  end

  def my_people
    Rails.cache.fetch("my_people",expirence_in: 1.hours) do 
    Person.where(user:  @user).order(:created_at).limit(10)
    end
  end
  def top_person
    Rails.cache.fetch("top_person",expirence_in: 1.hours) do 
    Person.order(:balance).last
    end
  end

  def bottom_person
    Rails.cache.fetch("bottom_person",expirence_in: 1.hours) do 
    Person.order(:balance).first
    end
  end

  def last_payments
    Rails.cache.fetch("last_payments",expirence_in: 1.hours) do 
    Payment.order(created_at: :desc).limit(10).map do |payment|
      [payment.id, payment.amount]
    end
    end
  end

  def total_debts
    Rails.cache.fetch("total_debts",expirence_in: 1.hours) do 
    Debt.where(person_id: active_people_ids).sum(:amount)
    end
  end
  
  def total_payments
    Rails.cache.fetch("total_payments",expirence_in: 1.hours) do 
    Payment.where(person_id: active_people_ids).sum(:amount)
    end
  end

  def balance
    Rails.cache.fetch("balance",expirence_in: 1.hours) do 
  total_payments - total_debts
    end
  end

  def active_people_ids
    Rails.cache.fetch("active_people_ids",expirence_in: 1.hours) do 
  Person.where(active: true).select(:id)
    end
  end

  
  def active_people_pie_chart
    Rails.cache.fetch("active_people_pie_chart",expirence_in: 1.hours) do 
   {
    active: Person.where(active: true).count,
     inactive: Person.where(active: false).count 
      }
    end

      
  end

end
