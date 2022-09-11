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
	iptables-save -f /etc/iptables/rules.v4/iptables.rules
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

	iptables -A OUTPUT -p udp -d 121.109.77.83 --dport 1695 -j ACCEPT



	#трафик через vpn
	iptables -A OUTPUT -o tun0 -j ACCEPT
	
	#TODO сделать чтение из файла
	iptables -A OUTPUT -p udp -d 219.100.37.84 -j ACCEPT


	}
localhost_out(){
	iptables -A OUTPUT -o lo -j ACCEPT
}



#маршрут
localhost_out
vpn_out


iptables -A OUTPUT -j LOG --log-level 7 --log-prefix "OUT:DROP " --log-uid
#блок
save
