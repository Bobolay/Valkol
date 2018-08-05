module ApplicationHelper
  def main_menu
    #brands_children = @menu_featured_brands.map{|b| {name: raw(b.name), active: false, url: b.url, resource: b } }
    recursive_menu([
       "about_us",
       {
         key: :services,
         active: action_name == 'index' && controller_name == "services",
         has_active: action_name != 'index' && controller_name == "services"
       },
       "pricing",
       {
         key: :publications,
         active: action_name == 'index' && (controller_name == "publications" || controller_name == 'interesting_articles'),
         has_active: action_name != 'index' && (controller_name == "publications" || controller_name == 'interesting_articles')
       },
       :contacts
     ])
  end

  def formatted_phone_number(phone)
    return phone

    s = phone.gsub(/[\+\(\)]/) do |s|
      "<span>#{s}</span>"
    end

    s.html_safe
  end

  def formatted_email(email)
    return email

    email.gsub('@', '<span>@</span>').html_safe
  end

  def skype_url(skype_name, call = true)
    s = "skype:#{skype_name}"
    if call
      s = "#{s}?call"
    end

    s
  end

  def _resolve_file_path(file_or_paperclip_attachment_or_model_instance)
    f = file_or_paperclip_attachment_or_model_instance
    paperclip_attachment = nil
    file_path = nil

    if f.is_a?(ActiveRecord::Base)
      if f.class.try(:attachment_definitions).present?
        paperclip_attachment = f.send(f.class.attachment_definitions.keys.first)
        return nil unless paperclip_attachment.exists?
        file_path = paperclip_attachment.path
      elsif f.is_a?(Paperclip::Attachment)
        return nil unless f.exists?
        file_path = f.path
      elsif f.is_a?(String)
        file_path = f
      elsif f.is_a?(File)
        file_path
      end
    end

    if !file_path.nil? && file_path.index('?')
      file_parts = file_path.split('/')
      if question_symbol_index = file_parts.last.index('?')
        file_parts.last = file_parts.last[0, question_symbol_index]
        file_path = file_parts.join('/')
      end
    end
    file_path
  end

  def _open_file(path_or_file_or_paperclip_attachment_or_model_instance)
    path = _resolve_file_path(path_or_file_or_paperclip_attachment_or_model_instance)
    if path.nil?
      return nil
    end
    @_opened_paths ||= {}
    if @_opened_paths[path].nil?
      if File.exists?(path)
        @_opened_paths[path] = File.open(path)
      end
    end

    @_opened_paths[path]
  end

  def file_size(file_or_paperclip_attachment_or_model_instance)
    f = _open_file(file_or_paperclip_attachment_or_model_instance)
    unless f.nil?
      f.size
    end
  end

  def human_file_size(file_or_paperclip_attachment_or_model_instance)
    size = file_size(file_or_paperclip_attachment_or_model_instance)
    if size.present?
      Filesize.from("#{size} B").pretty.upcase
    end
  end
end
