class RenameRaitiongToRatingInReviews < ActiveRecord::Migration[7.1]
  def change
    rename_column :reviews, :raitiong, :rating
  end
end
