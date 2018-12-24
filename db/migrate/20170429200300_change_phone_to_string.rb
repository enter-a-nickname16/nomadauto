class ChangePhoneToString < ActiveRecord::Migration[5.0]
  def change
    change_column(:companies, :phone_number, :integer)
  end
end
