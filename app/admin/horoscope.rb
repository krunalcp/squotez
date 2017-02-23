ActiveAdmin.register Horoscope do
  permit_params(
    :sign,
    :duration,
    :horoscope_text,
    other_details_attributes: [
      :id,
      :detailable_type,
      :detail_type,
      :detail,
      :_destroy
    ]
  )

  filter :sign
  filter :duration
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    id_column
    column :sign
    column :duration
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs "Horoscope" do
      f.input :sign
      f.input :duration
      f.input :horoscope_text
      unless f.object.new_record?
        f.has_many :other_details, allow_destroy: true, new_record: true do |ot|
          ot.input :detailable_type
          ot.input :detail_type
          ot.input :detail
        end
      end
    end
    f.actions
  end

  show do
    panel "Horoscope" do
      attributes_table_for horoscope do
        row :sign
        row :duration
        row :horoscope_text
        row :created_at
        row :updated_at
        panel "OtherDetail" do
          table_for horoscope.other_details do
            column :detailable_type
            column :detail_type
            column :detail
          end
        end
      end
    end
  end
end