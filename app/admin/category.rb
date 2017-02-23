ActiveAdmin.register Category do
  permit_params(
    :name,
    :type
  )

  filter :name
  filter :type
end