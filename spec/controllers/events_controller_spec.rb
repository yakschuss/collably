require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:my_event) {create(:event)}
  let(:my_user) {create(:user, first_name: "New", last_name: "User", confirmed_at: Time.now)}

  context "guest" do
    describe "GET show" do
      it "returns http 302" do
        get :show, id: my_event.id
        expect(response).to have_http_status(302)
      end

      it "redirects to the login page " do
        get :show, id: my_event.id
        expect(response).to redirect_to new_user_session_path
      end

    end

    describe "GET new" do
      it "returns http redirect" do
        get :new, event_id: my_event.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end


  context "authorized user working with own event" do
    before do
      sign_in my_user
    end

    describe "view" do
      it "succeeds" do
        get :show, id: my_event.id
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, id: my_event.id
        expect(response).to render_template :show
      end

      it "assigns my_event to @event" do
        get :show, id: my_event.id
        expect(assigns(:event)).to eq(my_event)
      end
    end

    describe "GET new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new, event_id: my_event.id
        expect(response).to render_template :new
      end

      it "instantiates @event" do
        get :new, event_id: my_event.id
        expect(assigns(:event)).to be_a_new(Event)
      end
    end

    describe "POST create" do
      it "increases the number of Events by 1" do
        expect{ post :create, event: {title: "A Title"} }.to change(Event,:count).by(1)
      end

      it "assigns the new event to @event" do
        post :create, event_id: my_event.id, event: {title: "A Title"}
        expect(assigns(:event)).to eq Event.last
      end

      it "redirects to the new event" do
        post :create, event: {title: "A Title"}
        expect(response).to redirect_to Event.last
      end
    end
  end

    context "admin inviting and updating users of his/her event" do

      describe "POST invite_user" do
        it "adds a new user to the event's users" do
          pending 'not complete'
          #how to test form_tag? need email: param to go through - my_user.email
          expect{ post :invite_user, id: my_event.id}.to change(my_event.users,:count).by(1)
        end
      end

      describe "POST update_user" do
        it "changes a specific user's role to admin" do
        pending 'not complete'
    #      post :update_user, id: my_event.id #again - testing form_tag - need parameter boolean
         expect(my_user.event_role(my_event.id)).to eq("admin")
        end
      end
    end
end
