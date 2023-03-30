class CreateDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :documents do |t|
      t.string :uuid
      t.string :pdf_url
      t.string :description
      t.json :document_data

      t.timestamps
    end
  end
end
