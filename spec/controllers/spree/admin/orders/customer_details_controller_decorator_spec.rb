require "spec_helper"
require "cancan"
require "spree/testing_support/bar_ability"

describe Spree::Admin::Orders::CustomerDetailsController, type: :controller do
  let(:user) { mock_model(Spree::User) }

  context "with authorization" do
    let(:order) do
      mock_model(
        Spree::Order,
        total:           100,
        number:          "R123456789",
        billing_address: mock_model(Spree::Address)
      )
    end

    before do
      allow(controller).to receive(:spree_current_user).and_return(user)
      allow(user).to receive(:generate_spree_api_key!).and_return(true)
      allow(controller).to receive(:authorize!).and_return(true)
      allow(controller).to receive(:authorize_admin).and_return(true)
      allow(Spree::Order).to receive_message_chain(:friendly, :find).and_return(order)
    end

    describe '#update' do
      let(:attributes) do
        {
          order_id: order.number,
          order: {
            email: "",
            use_billing: "",
            bill_address_attributes: {},
            ship_address_attributes: {}
          },
          guest_checkout: 'true'
        }
      end

      def send_request(params = {})
        put :update, params
      end

      context 'using guest checkout' do
        context 'having valid parameters' do
          before do
            allow(order).to receive_messages(update_attributes: true)
            allow(order).to receive_messages(next: false)
            allow(order).to receive_messages(complete?: true)
            allow(order).to receive_messages(refresh_shipment_rates: true)
          end

          context 'having successful response' do
            before { send_request(attributes) }
            it { expect(response).to have_http_status(302) }
            it { expect(response).to redirect_to(edit_admin_order_url(order)) }
          end

          context 'with correct method flow' do
            it { expect(order).to receive(:update_attributes).with(attributes[:order]) }
            it 'does refresh the shipment rates with all shipping methods' do
              expect(order).to receive(:refresh_shipment_rates).
                with(Spree::ShippingMethod::DISPLAY_ON_FRONT_AND_BACK_END)
            end
            it { expect(controller).to receive(:load_order).and_call_original }
            it { expect(controller).to_not receive(:load_user).and_call_original }
            after { send_request(attributes) }
          end
        end

        context 'having invalid parameters' do
          before do
            allow(order).to receive_messages(update_attributes: false)
          end

          context 'having failure response' do
            before { send_request(attributes) }
            it { expect(response).to render_template(:edit) }
          end

          context 'with correct method flow' do
            it { expect(order).to receive(:update_attributes).with(attributes[:order]) }
            it { expect(controller).to receive(:load_order).and_call_original }
            it { expect(controller).to_not receive(:load_user).and_call_original }
            after { send_request(attributes) }
          end
        end
      end
    end
  end
end
