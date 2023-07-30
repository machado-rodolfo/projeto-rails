prawn_document do |pdf|
  pdf.text 'Listando Perguntas', :align => :center, :size => 24
  pdf.move_down 20

  @questions.each do |q|
    pdf.text "ID: #{q.id}", :style => :bold
    pdf.text "Pergunta: #{q.description}"

    pdf.move_down 10
    pdf.text 'Respostas:', :style => :bold

    q.answers.each do |answer|
      answer_text = answer.description
      if answer.correct # Supondo que existe um atributo 'correct' na tabela de respostas para marcar a resposta correta
        pdf.text "* #{answer_text}", :indent_paragraphs => 10, :style => :bold
      else
        pdf.text answer_text, :indent_paragraphs => 10
      end
    end

    pdf.move_down 20
  end
end
