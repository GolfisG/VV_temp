
mail = 'up1066502@upnet.gr';   % your email
password = 'd6b7e06569';     % your password
mailingList = {'gas4pistons@gmail.com'}; % recipients email 
server = 'fmail.upnet.gr';     %your host's smtp server
props = java.lang.System.getProperties;
props.setProperty('mail.smtp.port','465');
props.setProperty('mail.smtp.starttls.enable','true');
setpref('Internet','E_mail',mail);
setpref('Internet','SMTP_Server',server);
setpref('Internet','SMTP_Username',mail);
setpref('Internet','SMTP_Password',password);
messageBody = sprintf('   Good morning team!');
messageBody = sprintf('%s\n\n   Here is the data analysis from yesterdays data. Have a great day!', messageBody);
messageBody = sprintf('%s\n\n   - Brian Gregory', messageBody);
messageBody = sprintf('%s\n\n\n   *This email was generated and sent automatically via MATLAB', messageBody);
sendmail(mailingList, 'MATLAB Test', messageBody);