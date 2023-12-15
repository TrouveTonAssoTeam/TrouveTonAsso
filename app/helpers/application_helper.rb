module ApplicationHelper
    def is_active?(*paths)
        paths.include?(request.path) ? 'active' : ''
    end
end
