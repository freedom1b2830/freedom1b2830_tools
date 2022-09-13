clear(){
	iptables -F
	iptables -X
	iptables -t nat -F
	iptables -t nat -X
	iptables -t mangle -F
	iptables -t mangle -X
	iptables -t raw -F
	iptables -t raw -X
	iptables -t security -F
	iptables -t security -X
	
	#iptables -P INPUT ACCEPT
	#iptables -P FORWARD ACCEPT
	#iptables -P OUTPUT ACCEPT
	
	#iptables -P INPUT ACCEPT
	#iptables -P FORWARD ACCEPT
	iptables -P OUTPUT DROP	
}
save(){
	iptables-save -f /etc/iptables/iptables.rules
}




clear




vpn_out(){
	#разрешения для впн 
#	iptables -A OUTPUT -p udp -d AAAAAAAAAAAA --dport BBBBBBBB -j ACCEPT
#	iptables -A OUTPUT -p udp -d AAAAAAAAAAAA --dport BBBBBBBB -j ACCEPT
#	iptables -A OUTPUT -p udp -d AAAAAAAAAAAA --dport BBBBBBBB -j ACCEPT
#	iptables -A OUTPUT -p udp -d AAAAAAAAAAAA --dport BBBBBBBB -j ACCEPT
#	iptables -A OUTPUT -p udp -d AAAAAAAAAAAA --dport BBBBBBBB -j ACCEPT
#	iptables -A OUTPUT -p udp -d AAAAAAAAAAAA --dport BBBBBBBB -j ACCEPT
#	iptables -A OUTPUT -p udp -d AAAAAAAAAAAA --dport BBBBBBBB -j ACCEPT
#	iptables -A OUTPUT -p udp -d AAAAAAAAAAAA --dport BBBBBBBB -j ACCEPT
#	iptables -A OUTPUT -p icmp -d AAAAAAAAAAAA -j ACCEPT	#ping
#	iptables -A INPUT -p icmp -d AAAAAAAAAAAA -j ACCEPT		#ping




	#трафик через vpn
	iptables -A OUTPUT -o tun0 -j ACCEPT
	#TODO сделать чтение из файла
	
	iptables -A OUTPUT -p udp -d 134.19.179.157 -j ACCEPT
	iptables -A OUTPUT -p udp -d 134.19.179.197 -j ACCEPT
	iptables -A OUTPUT -p udp -d 173.44.55.157 -j ACCEPT
	iptables -A OUTPUT -p udp -d 185.206.225.61 -j ACCEPT
	iptables -A OUTPUT -p udp -d 192.168.3.1 -j ACCEPT
	iptables -A OUTPUT -p udp -d 213.152.162.101 -j ACCEPT
	iptables -A OUTPUT -p udp -d 213.152.162.106 -j ACCEPT
	iptables -A OUTPUT -p udp -d 213.152.162.7 -j ACCEPT
	iptables -A OUTPUT -p udp -d 213.152.187.212 -j ACCEPT
	
	iptables -A OUTPUT -p tcp -d 54.93.175.114 -j ACCEPT
	iptables -A OUTPUT -p tcp -d 63.33.116.50 -j ACCEPT
	iptables -A OUTPUT -p tcp -d 63.33.78.166 -j ACCEPT
	iptables -A OUTPUT -p tcp -d 82.196.3.205 -j ACCEPT
	
	}
	
localhost_out(){
	iptables -A OUTPUT -o lo -j ACCEPT
}



#маршрут
localhost_out

#vpn серверы
vpn_out

iptables -A OUTPUT -m owner --uid-owner 0 -j LOG --log-level 7 --log-prefix "OUT:ROOT " --log-uid

#логирование попыток выйти
iptables -A OUTPUT -j LOG --log-level 7 --log-prefix "OUT:DROP " --log-uid
#блок
save
