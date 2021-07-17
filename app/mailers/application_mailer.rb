class ApplicationMailer < ActionMailer::Base
default from: "pruebadenviodecorreo@gmail.com"
layout 'mailer'

def new_envio_email
    @hola = 'david.palta.anes1989@gmail.com'
    mail(from: 'pruebadenviodecorreo@gmail.com', to: @hola, subject: "Nuevo producto agregado") do |format|
        format.text
        format.html
    end
  end

end
