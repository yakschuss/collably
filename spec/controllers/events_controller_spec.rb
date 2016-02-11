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
      before do
        my_event.update_user_role(my_event.users.first.id)
        admin = my_event.users.first
        sign_in admin
      end
      context "POST invite_user" do
        let(:invite_a_user){post :invite_user, id: my_event.id, users: {email: my_user.email}}
        it "adds a new user to the event's users" do
          expect{ invite_a_user }.to change(my_event.users,:count).by(1)
        end
      end

      context "POST update_user" do
        before do
          my_event.users << my_user
        end
        it "changes a specific user's role to admin" do
          post :update_user, id: my_event.id , user_id: my_user.id, boolean: 1
          expect(my_user.event_role(my_event.id)).to eq("admin")
        end
      end
    end
end
