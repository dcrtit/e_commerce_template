ActiveAdmin.register Product do

  belongs_to :category

  controller do
    def permitted_params
      params.permit!
    end
  end

  index do
    column :name
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description, as: :ckeditor
      f.input :url
    end
    f.actions
  end
end
