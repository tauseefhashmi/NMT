IPv4" tcpdump > ippacket

cut -d" " -f1 arppacket > timearp
cut -d" " -f2 arppacket > sourcemacarp
cut -d" " -f4 arppacket > destmacarp
cut -d" " -f12 arppacket > sourceiparp
cut -d" " -f14 arppacket > destiparp
cut -d" " -f9 arppacket > lengtharp

cut -d" " -f1 udppacket > timeudp
cut -d" " -f2 udppacket > sourcemacudp
cut -d" " -f4 udppacket > destmacudp
cut -d" " -f10 udppacket > sourceiudp
cut -d"." -f1,2,3,4 sourceiudp > sourceipudp
cut -d" " -f12 udppacket > destiudp
cut -d"." -f1,2,3,4 destiudp > destipudp
cut -d"." -f5 sourceiudp > sourceportudp
cut -d"." -f5 destiudp > destiportudp
cut -d" " -f9 udppacket > lengthudp

cut -d" " -f1 ippacket > timeip
cut -d" " -f2 ippacket > sourcemacip
cut -d" " -f4 ippacket > destmacip
cut -d" " -f10 ippacket > sourceiip
cut -d"." -f1,2,3,4 sourceiip > sourceipip
cut -d" " -f12 ippacket > destiip
cut -d"." -f1,2,3,4 destiip > destipip
cut -d"." -f5 sourceiip > sourceportip
cut -d"." -f5 destiip > destiportip
cut -d" " -f9 ippacket > lengthip

paste timearp sourcemacarp destmacarp sourceiparp destiparp  lengtharp > arp
paste timeudp sourcemacudp destmacudp sourceipudp destipudp sourceportudp destiportudp lengthudp > udp
paste timeip sourcemacip destmacip sourceipip destipip sourceportip destiportip lengthip > ip
mysql -u root -e"
DROP DATABASE if exists packets;
CREATE DATABASE packets;
USE packets;

DROP TABLE if exists arp_1;
DROP TABLE if exists ip_1;
DROP TABLE if exists udp_1;

CREATE table arp_1(
Time_Stamp VARCHAR(30),
Source_Mac_Address VARCHAR(30),
Destination_Mac_Address VARCHAR(30),
Source_IpAddress VARCHAR(30),
Destination_IpAddress VARCHAR(30),
Length VARCHAR(30));

CREATE table ip_1(
Time_Stamp VARCHAR(30),
Source_Mac_Address VARCHAR(30),
Destination_Mac_Address VARCHAR(30),
Source_IpAddress VARCHAR(30),
Destination_IpAddress VARCHAR(30),
Source_Port VARCHAR(30),
Destination_Port VARCHAR(30),
Length VARCHAR(30));

CREATE table udp_1(
Time_Stamp VARCHAR(30),
Source_Mac_Address VARCHAR(30),
Destination_Mac_Address VARCHAR(30),
Source_IpAddress VARCHAR(30),
Destination_IpAddress VARCHAR(30),
Source_Port VARCHAR(30),
Destination_Port VARCHAR(30),
Length VARCHAR(30));

LOAD DATA LOCAL INFILE '/var/www/html/arp' INTO TABLE packets.arp_1;
LOAD DATA LOCAL INFILE '/var/www/html/ip' INTO TABLE packets.ip_1;
LOAD DATA LOCAL INFILE '/var/www/html/udp' INTO TABLE packets.udp_1;";
