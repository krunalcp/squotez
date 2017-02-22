ActiveAdmin.register Notification do
  permit_params :notification_text,
                :type,
                :language,
                :author,
    categories_attributes:[
      :id,
      :name,
      :type,
      :_destroy
    ]

  filter :notification_text
  filter :type
  filter :language
  filter :author

  index do
    selectable_column
    id_column
    column :notification_text
    column :type
    column :language
    column :author
    actions
  end

  form do |f|
    f.inputs "Notification" do
      f.input :notification_text
      f.input :type
      f.input :language
      f.input :author
      f.has_many :categories, allow_destroy: true, new_record: true do |c|
        c.input :name
        c.input :type
      end
    end
    f.actions
  end
  show do
    panel "Notification" do
      attributes_table_for notification do
        row :notification_text
        row :type
        row :language
        row :author
        row :created_at
        row :updated_at
        panel "Categories" do
          table_for notification.categories do
            column :name do |categories|
              link_to(categories.name,admin_category_path(categories.id))
            end
            column :type
          end
        end
      end
    end
  end
end