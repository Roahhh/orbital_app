module ConvomessagesHelper
  def self_or_other(convomessage)
    convomessage.user == current_user ? "self" : "other"
  end

  def convomessage_interlocutor(convomessage)
    convomessage.user == convomessage.conversation.sender ? convomessage.conversation.sender : convomessage.conversation.recipient
  end
end