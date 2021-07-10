class EnvioTicketMailer < ApplicationMailer
     #Envio de correo electronico cuando se agrega un nuevo producto.
  def new_envio_email
    @hola = 'david.palta.anes1989@gmail.com'
    mail(to: @hola, subject: "Nuevo producto agregado", body: 'something')
  end

end
