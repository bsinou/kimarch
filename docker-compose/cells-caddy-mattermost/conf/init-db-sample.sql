
-- see https://medium.com/@yishengliu/docker-how-to-create-multiple-databases-1d1e3ed0db74 for instance

-- Mattermost
CREATE DATABASE IF NOT EXISTS mm_db;
CREATE DATABASE IF NOT EXISTS cells_db;

CREATE USER 'pydio'@'%' IDENTIFIED BY 'cells';
GRANT ALL ON *.* TO 'pydio'@'%';

