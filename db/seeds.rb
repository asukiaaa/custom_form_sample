# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

form1 = CustomForm.find_or_create_by(name: 'example form1')
form1.custom_inputs.find_or_create_by(label: 'text1', input_type: :text_field)
form1.custom_inputs.find_or_create_by(label: 'text2', input_type: :text_field)
form1.custom_inputs.find_or_create_by(label: 'multi lines text', input_type: :text_area)

form2 = CustomForm.find_or_create_by(name: 'example form2')
form2.custom_inputs.find_or_create_by(label: 'text1', input_type: :text_field)
form2.custom_inputs.find_or_create_by(label: 'text1（カタカナ）', input_type: :kana_text_field)
form2.custom_inputs.find_or_create_by(label: 'text2', input_type: :text_field)
form2.custom_inputs.find_or_create_by(label: 'お名前', input_type: :last_first_name, required: true)
