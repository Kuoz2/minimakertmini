class EnvioTicketMailer < ApplicationMailer
     #Envio de correo electronico cuando se agrega un nuevo producto.
  def new_envio_email(archivo)
    @hola = 'david.palta.anes1989@gmail.com'
      info = Base64.decode64(archivo.nombreXML.to_s)
      @url = 'https://marketmini.herokuapp.com/products'
      puts attachments['informacion.xml']  = File.read(URI.parse(info).open)

      
mail from: 'pruebadenviodecorreo@gmail.com', to: @hola, subject: "Nuevo producto agregado" , body: "hola mundo"
  end

end
