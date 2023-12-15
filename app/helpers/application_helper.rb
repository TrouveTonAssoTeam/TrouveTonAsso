module ApplicationHelper
    def is_active?(link_path)
        current_page?(link_path) ? "active" : ""
    end

    def organisation_jsonld(organisation)
        {
            "@context": "http://schema.org",
            "@type": "Organization",
            "name": organisation.name,
            "description": organisation.description,
            "address": organisation.address + ", " + organisation.zip + " " + organisation.city,
        }.to_json.html_safe
    end

    def event_jsonld(event)
        {
            "@context": "http://schema.org",
            "@type": "Event",
            "startDate": event.start_date,
            "endDate": event.end_date,
            "name": event.name,
            "description": event.description,
            "organizer": {
                "@type": "Organization",
                "name": event.organisation.name,
                "description": event.organisation.description,
                "address": event.organisation.address + ", " + event.organisation.zip + " " + event.organisation.city,
            }
        }.to_json.html_safe
    end
end
