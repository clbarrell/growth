json.array!(@template_questions) do |template_question|
  json.extract! template_question, :id, :text, :qntype, :scale, :default_order
  json.url template_question_url(template_question, format: :json)
end
