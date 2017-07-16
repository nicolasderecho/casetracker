require "searchlight/adapters/action_view"

class CaseSearch < Searchlight::Search
  include Searchlight::Adapters::ActionView

  def base_query 
    (options[:scope].presence || Case).all
  end

  def search_title_contains
    query.where(query.arel_table[:title].matches("%#{title_contains}%"))
  end

  def search_expedient_contains
    query.where(query.arel_table[:expedient].matches("%#{expedient_contains}%"))
  end

  def search_judge_contains
    query.where(query.arel_table[:judge].matches("%#{judge_contains}%"))
  end

  def search_status_eq
    query.where(query.arel_table[:status].eq(status_eq))
  end

end