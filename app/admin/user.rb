ActiveAdmin.register User do
  permit_params(
    :first_name,
    :last_name,
    :birth_date,
    :birth_sign,
    :gender,
    :email,
    :contact_no
  )

  filter :first_name
  filter :last_name
  filter :birth_sign
  filter :gender
  filter :email
  filter :contact_no
  
  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :birth_date
    column :birth_sign
    column :gender
    column :email
    column :contact_no
    actions
  end
end