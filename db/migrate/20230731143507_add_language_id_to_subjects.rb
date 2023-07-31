class AddLanguageIdToSubjects < ActiveRecord::Migration[5.2]
  def change
    add_column :subjects, :language_id, :integer
  end
end
