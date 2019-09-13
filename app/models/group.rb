class Group < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :bookmarks

  validates_presence_of :title

  private

    def self.get_group_user_counts(user)
      sql = "" +
        "SELECT gu.group_id, COUNT(gu.user_id) AS user_count " +
        "FROM groups_users gu WHERE gu.group_id IN " +
        "( SELECT group_id FROM groups_users WHERE user_id = #{user.id} ) " +
        "GROUP BY gu.group_id ORDER BY gu.group_id"

      counts = ActiveRecord::Base.connection.exec_query(sql)
      group_user_counts = {}

      counts.each do |c|
        group_user_counts[ c['group_id'] ] = c['user_count']
      end

      group_user_counts
    end

    def self.get_group_bookmark_counts(user)
      sql = "" +
        "SELECT g.id AS group_id, COUNT(b.id) AS bookmark_count " +
        "FROM groups g " +
        "INNER JOIN groups_users gu ON g.id = gu.group_id " +
        "INNER JOIN bookmarks b ON g.id = b.group_id " +
        "WHERE gu.user_id = #{user.id} " +
        "GROUP BY g.id " +
        "ORDER BY g.id"

        counts = ActiveRecord::Base.connection.exec_query(sql)
        group_bookmark_counts = {}

        counts.each do |c|
          group_bookmark_counts[ c['group_id'] ] = c['bookmark_count']
        end

        group_bookmark_counts
    end
end
