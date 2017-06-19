require 'rails_helper'

RSpec.describe Api::V1::AnswersController, type: :request do
  describe "GET /answers" do
    before :each do
      FactoryGirl.create_list(:answer, 10);
      get '/api/v1/answers'
    end
    it { have_http_status(200) }
    it "mande la lista de respuestas" do
      json = JSON.parse(response.body)
      #puts json
      expect(json.length).to eq(Answer.count)
    end
  end

  describe "GET /answers/:id" do
    before :each do
      @answer = FactoryGirl.create(:answer);
      get "/api/v1/answers/#{@answer.id}"
    end
    it { have_http_status(200) }
    it "manda la respuesta solicitada" do
      json = JSON.parse(response.body)
      #puts json
      expect(json["id"]).to eq(@answer.id)
    end

    it "manda los atributos de la respuesta" do
      json = JSON.parse(response.body)
      expect(json.keys).to contain_exactly("id", "answer")
    end
  end

  describe "POST /answers" do
    context "solicitud de peticion" do
      before :each do
        @answer = FactoryGirl.create(:answer)
        @params = { params: { answer: @answer.answer } }
        puts @answer.answer
        puts "--- qlito \n\n\n\n #{@answer.answer.inspect} \n\n\n ---"
        puts "--- qlito2 \n\n\n\n #{@params.inspect} \n\n\n ---"
        post "/api/v1/answers/", { params: @params }
      end
      it { have_http_status(200) }
      #it { change(Answer, :count).by(1) }
      it "crea una nueva encuesta" do
        expect{
          post "/api/v1/answers/", { params: @params }
          puts "--- \n\n\n\n #{@params} \n\n\n ---"
        }.to change(Answer, :count).by(1)
      end
      it "responde con la encuesta creada" do
        json = JSON.parse(response.body)
        #json = ActiveSupport::JSON.decode(response.body)
        puts "--- response \n\n\n\n #{json["answer"]} \n\n\n ---"
        #answer_result = JSON.parse(json["answer"])
        #puts "--- response4 \n\n\n\n #{answer_result} \n\n\n ---"
        #puts "--- response2 \n\n\n\n #{json[0]["result"]["nombre"]} \n\n\n ---"
        expect(json["answer"]["Cristian"]).to eq("Cristian")
      end
    end
  end
end
