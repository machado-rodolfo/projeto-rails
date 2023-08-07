require 'net/http'
class CEP
  attr_reader :logradouro, :bairro, :localidade, :uf

  END_POINT = "https://viacep.com.br/ws/"
  FORMAT = "json"

  def initialize(cep)
    cep_found = to_find(cep)
    fill_data(cep_found)
  end

  def address
    "#{@logradouro} / #{@bairro} / #{@localidade} / #{@uf}"
  end

  private

  def fill_data(cep_found)
    @logradouro = cep_found["logradouro"]
    @bairro     = cep_found["bairro"]
    @localidade = cep_found["localidade"]
    @uf         = cep_found["uf"]
  end

  def to_find(cep)
    ActiveSupport::JSON.decode(
      Net::HTTP.get(
        URI("#{END_POINT}#{cep}/#{FORMAT}/")
      )
    )
  end
end
