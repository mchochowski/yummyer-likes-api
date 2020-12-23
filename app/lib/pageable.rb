# frozen_string_literal: true

module Pageable
  DEFALT_PAGE_SIZE = 20
  DEFALT_OFFSET = 0

  def limit
    params[:limit]&.to_i || DEFALT_PAGE_SIZE
  end

  def offset
    params[:offset]&.to_i || DEFALT_OFFSET
  end

  def page_data(total)
    {
      meta: { total: total },
      links: links(total)
    }
  end

  def links(total)
    links = { self: full_url }
    links[:next] = full_url(new_offset: offset + limit) if offset + limit < total
    links[:prev] = full_url(new_offset: offset - limit) unless offset == DEFALT_OFFSET
    links
  end

  def full_url(new_offset: nil)
    if new_offset
      endpoint_url(query_params(new_offset: new_offset))
    else
      endpoint_url(query_params)
    end
  end
end
