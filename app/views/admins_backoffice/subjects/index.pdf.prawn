prawn_document do |pdf|
  pdf.text 'Listando Assuntos', :align => :center, :size => 24
  pdf.move_down 20

  data = [['ID', 'Assunto', 'Questões']]

  @subjects.each do |subject|
    data << [subject.id, subject.description, { content: "#{subject.questions_count} questões", align: :right }]
  end

  pdf.table(data, column_widths: [50, 200, 100])
end
