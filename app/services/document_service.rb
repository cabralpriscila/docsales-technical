class DocumentService
  def self.list
    Document.all.map do |document|
      {
        uuid: document.uuid,
        pdf_url: document.pdf_url,
        description: document.description,
        document_data: document.document_data,
        created_at: document.created_at
      }
    end
  end

  def self.create(params)
    html = params[:template].gsub(/\{\{(\w+)\}\}/) do |match|
      params[:document_data][$1.to_sym]
    end

    pdf = PDFKit.new(html).to_pdf

    file_path = Rails.root.join('public', 'pdfs', "#{SecureRandom.uuid}.pdf")
    File.open(file_path, 'wb') do |file|
      file << pdf
    end

    document = Document.new(
      uuid: SecureRandom.uuid,
      pdf_url: file_path.to_s,
      description: params[:description],
      document_data: params[:document_data]
    )
    document.save

    {
      uuid: document.uuid,
      pdf_url: document.pdf_url,
      description: document.description,
      document_data: document.document_data,
      created_at: document.created_at
    }
  end
end
