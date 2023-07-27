prawn_document do |pdf|
  pdf.text 'Listando Perguntas', :align => :center, :size => 24
  pdf.move_down 20
  pdf.table @questions.collect{|q| [q.id,q.description]}
end
