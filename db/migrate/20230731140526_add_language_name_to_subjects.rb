class AddLanguageNameToSubjects < ActiveRecord::Migration[5.2]
  def change
    add_column :subjects, :language_name, :string
  end
end
