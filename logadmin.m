function [logs] = logadmin()

res = sql("SELECT * FROM logs");
logs(:,1) = res(:,2);
logs(:,2) = res(:,3);
logs(:,3) = res(:,4);

end