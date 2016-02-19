require 'rails_helper'

RSpec.describe TodosController, type: :controller do
  let(:user) {create(:user, confirmed_at: Time.now)}
  let(:event) {create :event}
  let(:todo) {Todo.create!(name: "A name", event: event)}


  context "signed-in example_user doing CD on a comment they own" do
    before do
      sign_in user
    end

    describe "POST create" do
      it "increase the number of todos by 1" do
        expect {post :create, format: :js, event_id: event.id, todo: {name:"This is a test"} }.to change(event.todos, :count).by(1)
      end

      it "returns http redirect" do
        post :create, format: :js, event_id: event.id, todo: {name: "This is a test"}
        expect(response).to have_http_status(:success)
      end
    end

    describe "DELETE destroy" do
      it "deletes the todo" do
        delete :destroy, format: :js, event_id: event.id, id: todo.id
        count = Todo.where({id: todo.id}).count
        expect(count).to eq 0
      end

      it "returns http success" do
        delete :destroy, format: :js, event_id: event.id, id: todo.id
        expect(response).to have_http_status(:success)
      end
    end
  end
end
