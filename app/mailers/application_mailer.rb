class ApplicationMailer < ActionMailer::Base
#default from: "pruebadenviodecorreo@gmail.com"
#layout 'mailer'

def new_envio_email
    @hola = 'adolfotyther@gmail.com'
    @url = 'https://marketmini.herokuapp.com/products'
    mail from: 'pruebadenviodecorreo@gmail.com', to: @hola, subject: "Hay productos vencidos. " , body: "Existen productos vencidos. Revise en vencidos en la pagina o desde este link: https://vyt-computacion.herokuapp.com/#/products/physical/vencimiento"
end

end
