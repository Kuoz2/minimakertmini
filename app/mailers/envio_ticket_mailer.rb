
class EnvioTicketMailer < ApplicationMailer

  #Envio de correo electronico cuando se agrega un nuevo producto.
  def new_envio_email(archivo)
    @hola = 'david.palta.anes1989@gmail.com'
    puts "lo que imprime"
    puts archivo.product.pdetalle

    vfecha = archivo.voucher.vfecha
    vtotal = archivo.voucher.vtotal
    vdia = archivo.voucher.vdia 
    vhora = archivo.voucher.vhora

     # info = Base64.decode64(archivo.nombreXML)
      #@url = 'https://marketmini.herokuapp.com/products'
      #uri = URI.parse(info.to_s)
      #attachments['info.xml'] 
      #puts "lo que imprime"
      #Nokogiri.parse open(info)
      #Net::HTTP.get_response(uri).body
      #loquecambia = URI.decode_www_form(info)
      #nako = Nokogiri.XML(loquecambia)
      #File.open("informacion.xml", "w+"){|f| f.write(loquecambia)}
      #orig_doc = Nokogiri::XML(loquecambia.to_s)
      #puts loquecambia
      builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
        xml.ted {
          xml.dd {
            xml.re '17246370-3'
            xml.td '39'
            xml.f '10'
            xml.fe "'#{vfecha}'"
            xml.rr '17246370-3'
            xml.rsr 'sin informacion'
            xml.mnt "'#{vtotal}'"
            xml.caf {
              xml.da {
                xml.re '17246370-3'
                xml.rs 'botilleria'
                xml.td '39'
                xml.rng {
                  xml.d '21oin-12$&%$&%$/mskadkasl'
                  xml.h 'sdjknfop009#$#$%&%'
                }
                xml.fa '2002-06-10'
                xml.rsapk{
                  xml.m 'modulo'
                  xml.e 'exponente'
                }
                xml.idk 'idk'
               }
               xml.frmt 'algoritmosha'
               xml.tsted "'#{vhora}'"
               xml.dd
            }
          }
        }
      end
      File.write("archivocml.xml", builder.to_xml)
      #puts builder.to_xml
      #File.write("archivo.xml", builder.to_xml)
     # puts orig_doc = Nokogiri.HTML.parse(open(info))
      #puts  URI::Data.new(loquecambia.join )
      #loquecambia.each do |single|
      #  puts html = "<a href='#{single.join}'>"

      #puts single.split.join
       # puts URI::Data.new(single.join)
      
      #end

      
      
      #viendodatos = URI::Data.new(loquecambia)
      #datanewinfo = URI::Data.new(loquecambia)
     # data = URI::Data.new(loquecambia)
      #File.write("informacin.xml", data.data)
      #puts info
      # mail from: 'pruebadenviodecorreo@gmail.com', to: @hola, subject: "Nuevo producto agregado" , body: "hola mundo"
  end
end

