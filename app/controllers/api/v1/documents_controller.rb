module Api
  module V1
    class DocumentsController < ApplicationController
      
      def list
        render json: Document.all
      end
      
      def create
        document = Document.new(document_params)
        if document.save
          render json: { status: "success", data: { uuid: document.uuid } }, status: :created
        else
          render json: { status: "error", errors: document.errors }, status: :unprocessable_entity
        end
      end
      
      private
      
      def document_params
        params.permit(:description, :template, document_data: {})
      end      
    end
  end
end
