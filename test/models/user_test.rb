# == Schema Information
#
# Table name: users
#
#  id                         :integer          not null, primary key
#  username                   :string           not null
#  password_digest            :string           not null
#  session_token              :string           not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  default_team_membership_id :integer
#  is_demo                    :boolean          default(FALSE), not null
#  avatar_url                 :string           not null
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
