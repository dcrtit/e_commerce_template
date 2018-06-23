ActiveAdmin.register Category do

  controller do
    def permitted_params
      params.permit!
    end
  end

  form do |f|
    f.inputs do
      f.input :category
      f.input :name
      f.input :description, as: :ckeditor
      f.input :url
    end
    f.actions
  end

end
