function [mails] = mailadmin()

res = sql("SELECT * FROM mails");
mails(:,1) = res(:,2);
mails(:,2) = res(:,3);
mails(:,3) = res(:,4);
mails(:,4) = res(:,5);

end