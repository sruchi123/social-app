class ConversationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "Conversation_#{params["conversation_id"]}"
  end

  def speak(data)
    # sender    = get_sender(data)
    # room_id   = data['room_id']
    # message   = data['message']

    # raise 'No room_id!' if room_id.blank?
    # convo = get_convo(room_id) # A conversation is a room
    # raise 'No conversation found!' if convo.blank?
    # raise 'No message!' if message.blank?

    # # adds the message sender to the conversation if not already included
    # convo.users << sender unless convo.users.include?(sender)
    # # saves the message and its data to the DB
    # # Note: this does not broadcast to the clients yet!
    # Message.create!(
    #   conversation: convo,
    #   sender: sender,
    #   content: message
    # )
  end
end