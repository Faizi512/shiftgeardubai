ActiveAdmin.register Car do
  Formtastic::FormBuilder.perform_browser_validations = true
  # before_action :skip_sidebar!, :only => :index
  config.filters = false

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :number, :model, :price, :image, :category_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :number, :model, :price]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Car Details" do
     f.input :name, input_html: {required: true} 
     f.input :number, input_html: {required: true} 
     f.input :model, input_html: {required: true} 
     f.input :price, input_html: {required: true} 
     f.input :category_id , :as => :select, :collection => Category.all.collect {|category| [category.name, category.id] }
     f.input :image, :as => :file, input_html: {required: true} 
   end
   f.actions
  end

  index do
    id_column
    column :name
    column :number
    column :model
    column :price
    column :category_id do |car|
      Category.find(car.category_id).name
    end
    column :image do |car|
      image_tag(car.image.url(:thumb))
    end
    actions
  end
  

  show do |ad|
    attributes_table do
      row :name
      row :category_id do
        Category.find(ad.category_id).name
      end
      row :number
      row :model
      row :price
      row :image do
        image_tag(ad.image.url(:thumb))
      end
      # Will display the image on show object page
    end
   end

  
end
