namespace :dev do

require 'faker'

DEFAULT_PASSWORD = 123456
DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')

  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando banco de dados...") { %x(rails db:drop) }
      show_spinner("Criando banco de dados...") { %x(rails db:create) }
      show_spinner("Migrando banco de dados...") { %x(rails db:migrate) }
      show_spinner("Cadastrando o administrador padrão...") { %x(rails dev:add_default_admin) }
      show_spinner("Cadastrando administradores extras...") { %x(rails dev:add_extra_admins) }
      show_spinner("Cadastrando o usuário padrão...") { %x(rails dev:add_default_user) }
      show_spinner("Cadastrando assuntos padrões...") { %x(rails dev:add_subjects) }
      show_spinner("Cadastrando perguntas e respostas...") { %x(rails dev:add_answers_and_questions) }
    else
      puts "Você não está em ambiente de desenvolvimento!"
    end
  end

  desc "Adiciona o administrador padrão"
  task add_default_admin: :environment do
    Admin.create(
      email:'admin@admin.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc "Adiciona administradores extras"
  task add_extra_admins: :environment do
    emails = []

    10.times do |i|
      email = Faker::Internet.email
      emails << email

      Admin.create(
        email: email,
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
      )
    end

    File.open('faker_email_list.txt', 'w') do |file|
      file.puts(emails)
    end
  end

  desc "Adiciona o usuário padrão"
  task add_default_user: :environment do
    User.create(
      email:'user@user.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

# Adiciona assuntos padrão
desc "Adiciona assuntos padrão"
task add_subjects: :environment do
  # Código para adicionar assuntos padrão (se necessário)
end

# Adiciona perguntas e respostas
desc "Adiciona perguntas e respostas"
task add_answers_and_questions: :environment do
  subjects_data = []

  # Lê o arquivo "answers_and_questions.txt" e popula o array subjects_data
  file_name = 'answers_and_questions.txt'
  file_path = File.join(DEFAULT_FILES_PATH, file_name)

  current_subject = nil
  current_question = nil
  current_answers = []
  correct_answer = nil
  File.open(file_path, 'r').each do |line|
    line = line.strip
    if line.start_with?('S:')
      current_subject = line[2..].strip
      current_question = nil
    elsif line.start_with?('Q:')
      current_question = line[2..].strip
      current_answers = []
      correct_answer = nil
    elsif line.start_with?('A:')
      current_answers << line[2..].strip
    elsif line.start_with?('CA:')
      correct_answer = line[3..].strip
      current_answers << correct_answer unless current_answers.include?(correct_answer)
      subjects_data << { subject: current_subject, question: current_question, answers: current_answers, correct: correct_answer }
    end
  end

  create_questions_and_answers(subjects_data)
end

# Método para criar perguntas e respostas com base nos dados lidos do arquivo
def create_questions_and_answers(subjects_data)
  subjects_data.each do |data|
    subject = Subject.find_or_create_by(description: data[:subject])
    question = Question.create!(description: data[:question], subject: subject)

    data[:answers].shuffle!  # Embaralha as respostas para que a resposta correta não seja sempre a primeira

    data[:answers].each do |answer|
      question.answers.create!(description: answer, correct: answer == data[:correct])
    end
  end
end


# Reseta o contador dos assuntos
desc "Reseta o contador dos assuntos"
task reset_subject_counter: :environment do
  # Código para resetar o contador dos assuntos (se necessário)
end

private


  def show_spinner(msg_start, msg_end = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end
