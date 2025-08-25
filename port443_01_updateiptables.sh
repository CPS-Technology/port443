echo ''
echo '-----------------------------'
echo 'Refresh iptable rules for port 443'

echo '- Delete all iptable customized rules'
sudo iptables -D INPUT -p tcp --dport 443 -j LOG --log-prefix='HTTPSPROBE ' -m comment --comment "Monitoring port 443 INPUT" --log-level 4 
sudo iptables -D OUTPUT -p tcp --dport 443 -j LOG --log-prefix='HTTPSPROBE ' -m comment --comment "Monitoring port 443 OUTPUT" --log-level 4 
sudo iptables -D FORWARD -p tcp --dport 443 -j LOG --log-prefix='HTTPSPROBE ' -m comment --comment "Monitoring port 443 FORWARD" --log-level 4 

echo '- Add back all iptable customized rules'
sudo iptables -A INPUT -p tcp --dport 443 -j LOG --log-prefix='HTTPSPROBE ' -m comment --comment "Monitoring port 443 INPUT" --log-level 4 
sudo iptables -A OUTPUT -p tcp --dport 443 -j LOG --log-prefix='HTTPSPROBE ' -m comment --comment "Monitoring port 443 OUTPUT" --log-level 4 
sudo iptables -A FORWARD -p tcp --dport 443 -j LOG --log-prefix='HTTPSPROBE ' -m comment --comment "Monitoring port 443 FORWARD" --log-level 4 

echo ''
echo '-----------------------------'
echo 'Check current iptables rules:'
sudo iptables -S

echo ''
