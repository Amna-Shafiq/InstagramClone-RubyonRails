# frozen_string_literal: true

class AddConfirmableToDevise < ActiveRecord::Migration[5.2]
  def up
    add_column :accounts, :confirmation_token, :string
    add_column :accounts, :confirmed_at, :datetime
    add_column :accounts, :confirmation_sent_at, :datetime
    add_column :accounts, :unconfirmed_email, :string # Only if using reconfirmable
    add_index :accounts, :confirmation_token, unique: true
    # User.reset_column_information # Need for some types of updates, but not for update_all.
    # To avoid a short time window between running the migration and updating all existing
    # users as confirmed, do the following
    # User.update_all confirmed_at: DateTime.now
    # All existing user accounts should be able to log in after this.
  end

  def down
    remove_index :accounts, :confirmation_token
    remove_columns :accounts, :confirmation_token, :confirmed_at, :confirmation_sent_at
    remove_columns :accounts, :unconfirmed_email # Only if using reconfirmable
  end
end
