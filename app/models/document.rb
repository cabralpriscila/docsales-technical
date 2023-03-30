class Document < ApplicationRecord
  attribute :template, :string
  attribute :pdf_url, :string, default: "https://example.com/default.pdf"
  attribute :uuid, :string, default: -> { SecureRandom.uuid }
  
  validates_presence_of :uuid, :pdf_url, :description, :document_data
  
  def document_data=(data)
    super(data.to_json)
  end

  def document_data
    JSON.parse(super)
  end

  def generate_uuid
    self.uuid ||= SecureRandom.uuid
  end
end
