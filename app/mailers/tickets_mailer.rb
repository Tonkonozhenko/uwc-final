class TicketsMailer < ActionMailer::Base
  default from: 'uwc@tonkonozhenko.com'

  def ticket_email(email, tickets = [])
    tickets.each do |t|
      file_name = "ticket_#{t.id}.pdf"

      @ticket = t
      pdf = render_to_string pdf: file_name, template: 'tickets/show.pdf.erb', encoding: 'UTF-8'

      # then save to a file
      save_path = "#{Rails.root}/tmp/tmp_zip_" << Time.now.to_f.to_s << '.zip'
      File.open(save_path, 'wb') { |file| file << pdf }

      attachments[file_name] = File.read(save_path)

      File.delete save_path
    end

    mail(to: email, subject: 'Successful buying')
  end
end
