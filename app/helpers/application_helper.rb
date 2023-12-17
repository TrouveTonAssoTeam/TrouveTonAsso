module ApplicationHelper
    def is_active?(link_path)
        current_page?(link_path) ? "active" : ""
    end
        def canonical_url
          request.original_url
        end
end
