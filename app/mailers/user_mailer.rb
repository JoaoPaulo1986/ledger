require 'csv'
class UserMailer < ApplicationMailer
    default from: 'no_reply@example.com'
     
      def balance_report_email(user)
    
        #aqui teremos a lista de todas as pessoas
        @people = Person.order(:name)

        #aqui geramos o conteúdo CSV
        csv_content = generate_csv() 
    
        # aqui anexamos o arquivo CSV ao e-mail
        attachments['balance_report.csv'] = { mime_type: 'text/csv', content: csv_content } 
        
        # aqui enviamos o email com o anexo
        mail(to: user.email, subject: 'Relatorio _ Teste Aplicacao Ledger', attachments: attachments)
      end
    
      def generate_csv()
        CSV.generate(headers: true) do |csv|
    
          csv << ['Nome', 'Saldo'] # o cabeçalho do arquivo
    
          @people.each do |person| 
            csv << [person.name, person.balance]
          end
          
        end
      end

    end