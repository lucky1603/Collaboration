PODESAVANJE KONFIGURACIJE APLIKACIJE ZA KOLABORACIJU

Posle instalacije, odnosno kloniranja repozitorijuma 'Collaboration.git' u direktorijum 'collaboration':

git clone http://github.com/lucky1603/Collaboration.git collaboration

neophodno je uraditi jos sledece stvari kako bi aplikacija radila.

1. Instalirati bazu

	- Ako nema postgresql instalirati
	- Kreirati ntkp bazu i uraditi 'restore' baze iz sql fajla u poddirektorijumu 'databases'

2. Editovati configuracioni fajl apache-a sa virtuelnim hostovima

	<VirtualHost *:80>
		ServerName collaboration
		DocumentRoot e:\xampp\htdocs\collaboration\public
		SetEnv APPLICATION_ENV "development"  
		 <Directory e:\xampp\htdocs\collaboration\public>
			DirectoryIndex index.php    
			AllowOverride All    
			Require all granted
		</Directory>
	</VirtualHost>	
	
3. Editovati 'hosts' fajl i ubaciti

127.0.0.1	collaboration

4. Instalirati composer ako ga nema (http://getcomposer.org) i izvrsiti sledece komande u direktorijumu 'collaboration'

	composer install
	composer update
	
5. U php.ini fajlu otkomentarisati sledece linije:
	
	extension=php_pdo_pgsql.dll
	extension=php_pgsql.dll