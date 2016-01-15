require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:my_event) {create(:event)}
  let(:my_user) {create(:user, confirmed_at: Time.now)}

  context "guest" do
    describe "GET show" do
      it "returns http 302" do
        get :show, event_id: my_event.id
        expect(response).to have_http_status(302)
      end

      it "redirects to the login page " do
        get :show, event_id: my_event.id
        expect(response).to redirect_to new_user_session_path
      end

      it "assigns my_event to @event" do
        get :show, event_id: my_event.id
        expect(assigns(:event)).to eq(my_event)
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
        get :show, event_id: my_event.id
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, event_id: my_event.id
        expect(response).to render_template :show
      end

      it "assigns my_event to @event" do
        get :show, event_id: my_event.id
        expect(assigns(:event)).to eq(my_event)
      end
    end

    describe "GET new" do
      it "returns http success" do
        get :new, event_id: my_event.id
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new, event_id: my_event.id
        expect(response).to render_template :new
      end

      it "instantiates @event" do
        get :new, event_id: my_event.id
        expect(assigns(:event)).not_to be_nil
      end
    end

    describe "POST create" do
      it "increases the number of Events by 1" do
        expect{ post :create, event_id: my_event.id, event: {title: "A Title"} }.to change(Event,:count).by(1)
      end

      it "assigns the new event to @event" do
        post :create, event_id: my_event.id, post: {title: "A Title"}
        expect(assigns(:event)).to eq Event.last
      end

      it "redirects to the new event" do
        post :create, event_id: my_event.id, post: {title: "A Title"}
        expect(response).to redirect_to #event path - TBD
      end
    end
  end

=begin
    describe "GET edit" do
      it "returns http success" do
        get :edit, event_id: my_event.id
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, event_id: my_event.id
        expect(response).to render_template :edit
      end

      it "assigns event to be updated to @event" do
        get :edit, event_id: my_event.id
        event_instance = assigns(:event)

        expect(event_instance.id).to eq my_event.id
        expect(event_instance.title).to eq my_event.title

      end
    end

    describe "PUT update" do
      it "updates event with expected attributes" do
        new_title = "A Title1"

        put :update, event_id: my_event.id, event: {title: new_title}

        updated_event = assigns(:event)
        expect(updated_event.id).to eq my_event.id
        expect(updated_event.title).to eq new_title

      end

      it "redirects to the updated event" do
        new_title = "A Title1"

        put :update, event_id: my_event.id, event: {title: new_title}
        expect(response).to redirect_to #event_path
      end
    end
=end
end
