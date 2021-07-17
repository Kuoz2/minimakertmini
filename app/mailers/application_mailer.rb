class ApplicationMailer < ActionMailer::Base
#default from: "pruebadenviodecorreo@gmail.com"
#layout 'mailer'

def new_envio_email
    @hola = 'david.palta.anes1989@gmail.com'
    @url = 'https://marketmini.herokuapp.com/products'
    mail from: 'pruebadenviodecorreo@gmail.com', to: @hola, subject: "Nuevo producto agregado" , body: "hola mundo", for: @url
end

end
