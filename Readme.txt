----------------------------------------- INSTRUCTION -----------------------------------------

PART 1: Add data into database
_ Create a database with a name 'onlinestore'
_ Restore the backup file in BackupDB folder
_ Copy 'DB_onlinestore.sql' in C:\ drive
mysql -u root -p onlinestore < DB_onlinestore.sql

------------------- *** -------------------

Note: This is a Maven-based project, so make sure you install Maven first to run the code properly

PART 2: Import the source code of Project
_ Run the NetBeans IDE
_ Select menu File\Open...
_ Link to the folder 'WebProj' of Project source code
_ Then click OK. NetBeans IDE will automatically add the project source code
_ Edit the username and password of MySQL at line 29-30 in DBConnection.java in dbconnection package
_ Right-click on the Project name (WebProj) select Clean and Build option.
_ Right-click on the Project name (WebProj) select Run option.
_ The Project will run on the default browser



