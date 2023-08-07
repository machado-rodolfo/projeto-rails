prawn_document do |pdf|
  pdf.text 'Listando Assuntos', :align => :center, :size => 24
  pdf.move_down 20

  data = [['ID', 'Linguagem', 'Assunto', 'Questões']]

  @subjects.each do |subject|
    language_name = subject.language.language_name # Obtém o nome da linguagem do assunto
    data << [subject.id, language_name, subject.description, { content: "#{subject.questions_count} questões", align: :right }]
  end

  pdf.table(data, column_widths: [50, 150, 150, 100]) # Ajuste as larguras das colunas conforme necessário
end
