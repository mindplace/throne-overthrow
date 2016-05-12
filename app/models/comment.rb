class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :votes, as: :voteable

  def destroy_dependencies
    votes.each{|vote| vote.destroy}
  end

  def count_votes
    return 0 if votes.empty? || votes.nil?
    votes.map{|vote| vote.value }.map(&:to_i).inject(:+)
  end

  def blurb
    return body if body.split.length <= 10
    body.split[0..10].join(" ") + "..."
  end
end
