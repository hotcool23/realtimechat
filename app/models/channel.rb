# == Schema Information
#
# Table name: channels
#
#  id                :integer          not null, primary key
#  name              :string           not null
#  team_id           :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  is_direct_message :boolean          default(FALSE)
#

class Channel < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { scope: :team_id,
    message: 'cannot be the same as another channel on this team' }
  validate :valid_name


  scope :recent, -> { order(created_at: :desc).limit(3) }

  ######################
  #  associations
  #####################

  belongs_to :team

  has_many :team_memberships_as_default,
    primary_key: :id,
    foreign_key: :default_channel_id,
    class_name: :TeamMembership

  has_many :channel_memberships,
    dependent: :destroy

  has_many :invites,
    dependent: :destroy

  has_many :users,
    through: :channel_memberships,
    source: :user

  has_many :messages,
    class_name: :Message

  ######################
  # custom validations
  #####################

  def valid_name
    unless valid_name?
      errors.add(:name, "must be lowercase, without spaces or periods," \
        " and shorter than 22 Characters.")
    end
  end

  def valid_name?
    return false if self.name =~ /[A-Z\s\.]/
    return false if self.name.length >= 22
    true
  end

  ######################
  # association methods
  #####################

  def self.subscribe_user_ids!(new_user_ids, channels)
    # channel_ids = channels.map(&:id)
    # channels = Channel.where('id IN (?)', channel_ids)
    channels.each do |channel|
      uniq_user_ids = channel.user_ids.concat(new_user_ids).uniq
      channel.user_ids = uniq_user_ids
    end

    # team_ids = channels.pluck(:team_id)
    #
    # teams = Team.where('id IN (?)', team_ids)
    # Team.subscribe_user_ids!(new_user_ids, teams)
  end

end
