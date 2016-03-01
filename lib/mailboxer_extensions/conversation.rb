module MailboxerExtensions
  module Mailboxer
    module Conversation
      extend ActiveSupport::Concern
          included do
            validates :subject, presence: true
      end
    end
  end
end
