module ApplicationHelper
  # Return a title on a per-page basis.
  def title
    base_title = "Ruby on Rails Tutorial Sample App"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  
  def multi_select(id, name, objects, selected_objects, value, content = {})
     options = ""
     objects.each do |o|
       selected = selected_objects.include?(o) ? " selected=\"selected\"" : ""
       option_value = escape_once(o.send(value))
       text = [option_value]
       unless content[:text].nil?
         text = []
         content[:text].each do |t|
           text << o.send(t)
         end
         text = text.join(" ")
       end
       bracket = []
       unless content[:bracket].nil?
         content[:bracket].each do |b|
           bracket << o.send(b)
         end
         bracket = bracket.join(" ")
       end
       option_content = bracket.empty? ? "#{text}" : "#{text} (#{bracket})"
       options << "<option value=\"#{option_value}\"#{selected}>#{option_content}</option>\n"
     end
     "<select multiple=\"multiple\" id=\"#{id}\" name=\"#{name}\">\n#{options}</select>"
   end
  
  
  
end
