# aug/24/2022 08:35:42 by RouterOS 6.48.6
# software id = 8E1V-4G71
#
# model = RB750Gr3
# serial number = D5030D2010D9
/interface ethernet
set [ find default-name=ether1 ] l2mtu=1508
set [ find default-name=ether2 ] l2mtu=1508
set [ find default-name=ether3 ] l2mtu=1600
set [ find default-name=ether4 ] l2mtu=1518
set [ find default-name=ether5 ] l2mtu=1500
/ip pool
add name=dhcp_pool5 ranges=192.168.0.2-192.168.0.254
add name=hs-pool-3 ranges=172.17.0.1-172.17.0.253
add name=dhcp_pool8 ranges=192.168.50.2-192.168.50.14
add name=dhcp_pool9 ranges=10.0.50.1-10.0.50.253
/ip dhcp-server
add address-pool=dhcp_pool8 disabled=no interface=ether4 name=dhcp1
add address-pool=dhcp_pool9 disabled=no interface=ether3 lease-time=1d name=\
    dhcp2
/queue type
add kind=pcq name=ping-dl pcq-classifier=src-address pcq-dst-address6-mask=64 \
    pcq-limit=10000KiB pcq-rate=32k pcq-src-address6-mask=64 pcq-total-limit=\
    5KiB
add kind=pcq name=ping-up pcq-classifier=src-address pcq-dst-address6-mask=64 \
    pcq-limit=10000KiB pcq-rate=32k pcq-src-address6-mask=64 pcq-total-limit=\
    5KiB
add kind=pcq name=hotspot-dl pcq-burst-rate=2200k pcq-burst-threshold=1500k \
    pcq-classifier=dst-address pcq-dst-address6-mask=64 pcq-limit=51000KiB \
    pcq-rate=2M pcq-src-address6-mask=64 pcq-total-limit=384KiB
add kind=sfq name=ping
add kind=pcq name=hotspot-ul pcq-burst-rate=2200k pcq-burst-threshold=1500k \
    pcq-classifier=src-address pcq-dst-address6-mask=64 pcq-limit=51000KiB \
    pcq-rate=2M pcq-src-address6-mask=64 pcq-total-limit=384KiB
add kind=sfq name=sfq-default sfq-perturb=10
add kind=pcq name=Ping_in_32K pcq-classifier=dst-address \
    pcq-dst-address6-mask=64 pcq-rate=32k pcq-src-address6-mask=64
add kind=pcq name=Ping_out_32K pcq-classifier=src-address \
    pcq-dst-address6-mask=64 pcq-rate=32k pcq-src-address6-mask=64
/queue simple
add dst=10.0.50.0/24 max-limit=800M/800M name="LOCAL 1" target=\
    10.0.50.0/24,192.168.50.0/28 total-queue=default
add dst=192.168.50.0/28 max-limit=800M/800M name="LOCAL 2" target=\
    10.0.50.0/24,192.168.50.0/28 total-queue=default
/queue tree
add name=Ping_in packet-mark=Ping_in parent=global queue=Ping_in_32K
add name=Ping_out packet-mark=Ping_out parent=global queue=Ping_out_32K
/snmp community
set [ find default=yes ] name=snmp-home
/system logging action
set 3 remote=192.168.0.2
/user group
set full policy="local,telnet,ssh,ftp,reboot,read,write,policy,test,winbox,pas\
    sword,web,sniff,sensitive,api,romon,dude,tikapp"
add name=hotspot policy="local,telnet,ssh,reboot,read,write,test,winbox,passwo\
    rd,web,sniff,sensitive,api,romon,tikapp,!ftp,!policy,!dude"
add name=api policy="telnet,ssh,sniff,api,!local,!ftp,!reboot,!read,!write,!po\
    licy,!test,!winbox,!password,!web,!sensitive,!romon,!dude,!tikapp"
/ip firewall connection tracking
set loose-tcp-tracking=no
/ip neighbor discovery-settings
set discover-interface-list=!dynamic
/ip address
add address=192.168.50.1/28 interface=ether4 network=192.168.50.0
add address=10.0.50.254/24 interface=ether3 network=10.0.50.0
add address=10.0.0.1/29 interface=ether5 network=10.0.0.0
add address=192.168.88.2/24 interface=ether1 network=192.168.88.0
add address=192.168.1.2/24 interface=ether2 network=192.168.1.0
/ip cloud
set update-time=no
/ip dhcp-server network
add address=10.0.50.0/24 dns-server=192.168.50.4,192.168.50.5 gateway=\
    10.0.50.254
add address=192.168.50.0/28 dns-server=8.8.8.8,8.8.4.4,208.67.220.220 \
    gateway=192.168.50.1
/ip dns
set cache-max-ttl=1d servers=192.168.50.4,192.168.50.5
/ip firewall address-list
add address=10.0.50.2-192.168.0.16 list=clients
add address=192.168.0.18-192.168.0.254 list=clients
add address=10.0.50.0/24 list="ip ranges"
add address=192.168.0.0/24 list="ip ranges"
add address=192.168.50.0/28 list="ip ranges"
add address=172.17.0.0/24 list="ip ranges"
add address=10.0.0.0/8 list=LAN
add address=172.16.0.0/12 list=LAN
add address=192.168.0.0/16 list=LAN
add address=0.0.0.0/8 comment="RFC 1122 \"This host on this network\"" list=\
    Bogons
add address=10.0.0.0/8 comment="RFC 1918 (Private Use IP Space)" disabled=yes \
    list=Bogons
add address=100.64.0.0/10 comment="RFC 6598 (Shared Address Space)" list=\
    Bogons
add address=127.0.0.0/8 comment="RFC 1122 (Loopback)" list=Bogons
add address=169.254.0.0/16 comment=\
    "RFC 3927 (Dynamic Configuration of IPv4 Link-Local Addresses)" list=\
    Bogons
add address=172.16.0.0/12 comment="RFC 1918 (Private Use IP Space)" disabled=\
    yes list=Bogons
add address=192.0.0.0/24 comment="RFC 6890 (IETF Protocol Assingments)" list=\
    Bogons
add address=192.0.2.0/24 comment="RFC 5737 (Test-Net-1)" list=Bogons
add address=192.168.0.0/16 comment="RFC 1918 (Private Use IP Space)" \
    disabled=yes list=Bogons
add address=198.18.0.0/15 comment="RFC 2544 (Benchmarking)" list=Bogons
add address=198.51.100.0/24 comment="RFC 5737 (Test-Net-2)" list=Bogons
add address=203.0.113.0/24 comment="RFC 5737 (Test-Net-3)" list=Bogons
add address=224.0.0.0/4 comment="RFC 5771 (Multicast Addresses) - Will affect \
    OSPF, RIP, PIM, VRRP, IS-IS, and others. Use with caution.)" disabled=yes \
    list=Bogons
add address=240.0.0.0/4 comment="RFC 1112 (Reserved)" list=Bogons
add address=192.31.196.0/24 comment="RFC 7535 (AS112-v4)" list=Bogons
add address=192.52.193.0/24 comment="RFC 7450 (AMT)" list=Bogons
add address=192.88.99.0/24 comment=\
    "RFC 7526 (Deprecated (6to4 Relay Anycast))" list=Bogons
add address=192.175.48.0/24 comment=\
    "RFC 7534 (Direct Delegation AS112 Service)" list=Bogons
add address=255.255.255.255 comment="RFC 919 (Limited Broadcast)" disabled=\
    yes list=Bogons
add comment="ASNVPN Script: false" list=vpnize-auto
add address=205.207.214.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=45.176.150.0/23 comment="ASNVPN Script: false" list=vpnize-auto
add address=140.106.223.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=62.122.96.0/21 comment="ASNVPN Script: false" list=vpnize-auto
add address=41.78.37.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=177.73.70.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=212.94.84.0/22 comment="ASNVPN Script: false" list=vpnize-auto
add address=169.239.85.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=109.160.80.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=78.108.250.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=109.160.68.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=109.160.79.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=129.205.64.0/20 comment="ASNVPN Script: false" list=vpnize-auto
add address=12.35.70.0/23 comment="ASNVPN Script: false" list=vpnize-auto
add address=103.75.158.0/23 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.4.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=45.9.216.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=154.65.12.0/22 comment="ASNVPN Script: false" list=vpnize-auto
add address=185.26.176.0/22 comment="ASNVPN Script: false" list=vpnize-auto
add address=179.63.216.0/22 comment="ASNVPN Script: false" list=vpnize-auto
add address=149.7.215.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=91.143.144.0/20 comment="ASNVPN Script: false" list=vpnize-auto
add address=45.82.88.0/22 comment="ASNVPN Script: false" list=vpnize-auto
add address=31.129.245.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=103.75.156.0/23 comment="ASNVPN Script: false" list=vpnize-auto
add address=45.229.70.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=179.63.216.0/21 comment="ASNVPN Script: false" list=vpnize-auto
add address=103.162.205.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.9.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.115.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.101.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.23.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.67.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.14.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.13.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.109.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.72.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.9.1.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.2.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.135.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.105.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.9.62.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.9.46.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.1.7.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.1.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.18.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.11.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.26.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.31.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=185.47.29.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.9.22.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.22.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=191.243.240.0/23 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.25.170.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.21.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.134.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.40.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.9.90.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.7.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=212.70.115.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.9.0.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.116.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.4.81.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.4.38.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.13.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.5.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.4.70.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.90.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=45.236.121.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=179.48.176.0/23 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.15.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.84.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.9.25.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=212.70.117.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.6.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.52.63.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=212.70.116.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.9.47.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=103.50.168.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.30.52.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.8.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.19.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.10.255.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=102.164.244.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.1.0.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.111.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.13.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.34.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.12.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.132.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.153.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.30.0.0/15 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.97.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.103.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.102.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.32.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.15.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.9.21.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.45.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.23.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.83.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=185.47.28.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.94.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.10.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=74.254.196.0/23 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.52.62.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.17.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.155.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.69.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.5.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.52.64.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.16.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=200.124.80.0/22 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.52.65.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.9.37.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.17.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.103.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.9.60.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=212.70.114.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.39.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.4.93.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.80.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.57.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.27.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.4.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.1.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.104.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.8.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.12.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.104.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.24.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.68.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.52.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=38.126.196.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.30.32.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.22.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.6.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.20.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.115.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.99.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.0.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.16.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.152.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.107.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.21.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.82.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.130.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.4.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.3.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.106.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.71.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.6.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.11.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=91.232.102.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.133.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.18.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.29.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.88.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.24.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.18.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.9.49.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.131.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.102.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.52.61.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=200.36.129.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.9.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.154.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.11.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.21.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.20.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.23.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.151.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.10.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.25.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=185.47.31.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.7.54.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.10.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=130.51.208.0/22 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.3.108.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.14.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=18.22.55.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=212.192.2.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=103.191.86.0/23 comment="ASNVPN Script: false" list=vpnize-auto
add address=103.181.14.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=191.243.242.0/23 comment="ASNVPN Script: false" list=vpnize-auto
add address=191.243.240.0/22 comment="ASNVPN Script: false" list=vpnize-auto
add address=45.70.141.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=45.70.140.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=45.70.143.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=45.70.140.0/22 comment="ASNVPN Script: false" list=vpnize-auto
add address=45.70.142.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=103.118.191.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.17.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=155.133.112.0/21 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.40.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.176.0/20 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.238.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.96.0/20 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.192.0/20 comment="ASNVPN Script: false" list=vpnize-auto
add address=206.117.6.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=206.117.31.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=91.225.188.0/22 comment="ASNVPN Script: false" list=vpnize-auto
add address=115.127.42.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=198.32.16.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.46.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.35.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.240.0/20 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.144.0/20 comment="ASNVPN Script: false" list=vpnize-auto
add address=206.117.37.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.234.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=168.228.216.0/22 comment="ASNVPN Script: false" list=vpnize-auto
add address=160.119.127.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.208.0/20 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.26.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.37.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.80.0/20 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.16.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.112.0/20 comment="ASNVPN Script: false" list=vpnize-auto
add address=115.127.40.0/22 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.224.0/20 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.31.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.28.0/23 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.44.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.18.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=206.117.27.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.236.0/22 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.47.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.20.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.160.0/20 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.48.0/20 comment="ASNVPN Script: false" list=vpnize-auto
add address=200.36.128.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=45.82.61.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.36.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.236.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.64.0/20 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.30.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=115.127.41.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.38.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.34.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.128.0/20 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.239.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.237.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.0.0/20 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.9.32.0/20 comment="ASNVPN Script: false" list=vpnize-auto
add address=81.16.242.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=103.178.171.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=103.61.8.0/22 comment="ASNVPN Script: false" list=vpnize-auto
add address=103.152.27.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=103.225.209.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.90.174.0/23 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.90.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.90.172.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.90.185.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.90.139.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=129.185.24.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.90.162.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.90.188.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=200.36.131.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.90.132.0/23 comment="ASNVPN Script: false" list=vpnize-auto
add address=129.185.32.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=129.185.30.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.90.129.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.90.140.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.90.181.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=129.185.34.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.90.187.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=200.36.130.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.90.128.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.90.164.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.90.183.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.90.164.0/22 comment="ASNVPN Script: false" list=vpnize-auto
add address=141.112.0.0/18 comment="ASNVPN Script: false" list=vpnize-auto
add address=138.122.92.0/23 comment="ASNVPN Script: false" list=vpnize-auto
add address=129.185.33.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.90.184.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.90.130.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.5.32.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=141.112.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.90.176.0/22 comment="ASNVPN Script: false" list=vpnize-auto
add address=129.185.35.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.90.150.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=129.185.31.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.90.191.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.90.136.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=170.246.32.0/22 comment="ASNVPN Script: false" list=vpnize-auto
add address=131.161.156.0/22 comment="ASNVPN Script: false" list=vpnize-auto
add address=194.32.218.0/23 comment="ASNVPN Script: false" list=vpnize-auto
add address=146.80.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.149.120.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=81.16.250.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.35.94.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=194.34.138.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.5.30.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.67.43.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.107.178.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=146.80.192.0/23 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.5.28.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=146.80.194.0/23 comment="ASNVPN Script: false" list=vpnize-auto
add address=194.61.92.0/23 comment="ASNVPN Script: false" list=vpnize-auto
add address=194.32.69.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=45.230.170.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=194.61.94.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=146.80.128.0/19 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.5.29.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=146.80.160.0/19 comment="ASNVPN Script: false" list=vpnize-auto
add address=45.230.168.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=45.230.171.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.136.144.0/22 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.42.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=168.3.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=168.4.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=168.7.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=168.6.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=168.5.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=208.90.184.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.136.148.0/23 comment="ASNVPN Script: false" list=vpnize-auto
add address=168.2.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=38.128.152.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.5.146.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.58.107.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.12.32.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.80.210.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=103.155.130.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=204.194.28.0/22 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.2.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=209.129.244.0/23 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.237.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=147.72.252.0/22 comment="ASNVPN Script: false" list=vpnize-auto
add address=131.72.168.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=179.48.46.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=202.73.107.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=216.165.96.0/20 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.76.177.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=216.165.64.0/19 comment="ASNVPN Script: false" list=vpnize-auto
add address=216.165.103.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=216.165.120.0/22 comment="ASNVPN Script: false" list=vpnize-auto
add address=216.165.0.0/18 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.86.139.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=216.165.112.0/21 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.122.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.63.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.5.24.0/23 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.33.13.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.12.67.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.20.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.12.65.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.12.82.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=209.2.47.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=209.2.208.0/20 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.59.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=160.39.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.5.43.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=129.236.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=207.10.136.0/21 comment="ASNVPN Script: false" list=vpnize-auto
add address=209.2.185.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=209.2.48.0/22 comment="ASNVPN Script: false" list=vpnize-auto
add address=209.2.224.0/20 comment="ASNVPN Script: false" list=vpnize-auto
add address=45.165.208.0/22 comment="ASNVPN Script: false" list=vpnize-auto
add address=131.243.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=102.36.164.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.3.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=163.245.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=204.52.48.0/20 comment="ASNVPN Script: false" list=vpnize-auto
add address=204.52.32.0/20 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.211.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.46.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.210.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=69.51.160.0/19 comment="ASNVPN Script: false" list=vpnize-auto
add address=205.215.64.0/18 comment="ASNVPN Script: false" list=vpnize-auto
add address=149.164.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.31.0.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.10.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=198.214.250.0/23 comment="ASNVPN Script: false" list=vpnize-auto
add address=198.214.80.0/20 comment="ASNVPN Script: false" list=vpnize-auto
add address=206.76.64.0/18 comment="ASNVPN Script: false" list=vpnize-auto
add address=146.6.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.62.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=198.213.192.0/18 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.83.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=129.116.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=205.153.240.0/22 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.33.134.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.131.125.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=140.162.192.0/18 comment="ASNVPN Script: false" list=vpnize-auto
add address=140.162.198.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=140.162.33.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=204.115.176.0/21 comment="ASNVPN Script: false" list=vpnize-auto
add address=140.162.13.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.5.8.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=140.162.64.0/18 comment="ASNVPN Script: false" list=vpnize-auto
add address=149.8.186.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=140.162.195.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=149.8.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=140.162.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.132.104.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.5.53.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=199.89.214.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.151.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=130.154.113.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=130.154.33.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=166.67.240.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=130.154.51.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=130.154.3.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.5.14.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=130.154.11.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=130.154.1.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=130.154.30.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=130.154.151.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=130.154.0.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=130.154.111.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=198.253.48.0/20 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.55.240.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.49.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=198.253.16.0/20 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.34.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=198.10.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.32.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.154.6.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=208.68.240.0/22 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.31.105.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.35.209.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.154.4.0/23 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.150.186.0/23 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.12.234.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=136.152.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=67.21.36.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=169.229.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=169.236.240.0/21 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.84.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.35.82.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.122.235.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.122.236.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=132.236.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.253.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=206.196.160.0/20 comment="ASNVPN Script: false" list=vpnize-auto
add address=206.196.184.0/21 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.54.100.0/22 comment="ASNVPN Script: false" list=vpnize-auto
add address=129.2.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.8.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.54.94.0/23 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.54.96.0/21 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.35.89.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.31.2.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=130.132.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.36.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.31.236.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=130.107.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.12.5.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.47.243.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.12.33.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.54.249.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=131.215.234.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.31.43.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=131.215.229.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=134.4.5.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.43.243.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.41.208.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=131.215.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.12.19.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=134.4.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=131.215.208.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.12.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=204.63.224.0/21 comment="ASNVPN Script: false" list=vpnize-auto
add address=171.64.0.0/14 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.56.58.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.56.59.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=15.65.198.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.56.61.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=15.65.192.0/21 comment="ASNVPN Script: false" list=vpnize-auto
add address=15.65.200.0/21 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.175.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=38.115.62.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.52.194.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.48.114.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=66.170.224.0/21 comment="ASNVPN Script: false" list=vpnize-auto
add address=66.170.232.0/21 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.29.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.12.24.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=129.83.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.160.51.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.48.115.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.80.55.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=198.49.146.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.12.120.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=199.10.8.0/22 comment="ASNVPN Script: false" list=vpnize-auto
add address=199.10.11.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=199.10.10.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=198.91.71.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=198.91.67.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=198.91.64.0/21 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.38.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=198.91.70.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=199.10.12.0/23 comment="ASNVPN Script: false" list=vpnize-auto
add address=198.91.72.0/23 comment="ASNVPN Script: false" list=vpnize-auto
add address=198.91.64.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=128.174.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=130.126.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.17.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=72.36.64.0/18 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.33.128.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.12.15.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=130.199.0.0/16 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.203.218.0/24 comment="ASNVPN Script: false" list=vpnize-auto
add address=192.153.161.0/24 comment="ASNVPN Script: false" list=vpnize-auto
/ip firewall filter
add action=drop chain=input comment="BLOCK DDOS" dst-port=53 in-interface=\
    ether1 protocol=udp
add action=drop chain=input dst-port=53 in-interface=ether1 protocol=tcp
add action=drop chain=input comment="BLOCK DDOS" dst-port=53 in-interface=\
    ether2 protocol=udp
add action=drop chain=input dst-port=53 in-interface=ether2 protocol=tcp
add action=jump chain=input comment="Jump to RFC Bogon Chain" jump-target=\
    "RFC Bogon Chain"
add action=jump chain=forward comment="Jump to RFC Bogon Chain" jump-target=\
    "RFC Bogon Chain"
add action=drop chain="RFC Bogon Chain" comment=\
    "Drop all packets soured from Bogons" src-address-list=Bogons
add action=drop chain="RFC Bogon Chain" comment=\
    "Drop all packets destined to Bogons" dst-address-list=Bogons
add action=return chain="RFC Bogon Chain" comment=\
    "Return from RFC Bogon Chain"
add action=drop chain=forward comment="drop invalid connections" \
    connection-state=invalid protocol=tcp
add action=accept chain=forward comment="Accept Cache" src-address=\
    192.168.50.8
add action=jump chain=input comment="Jump to RFC ICMP Protection Chain" \
    jump-target="RFC ICMP Protection" protocol=icmp
add action=jump chain=forward comment="Jump to RFC ICMP Protection Chain" \
    jump-target="RFC ICMP Protection" protocol=icmp
add action=add-dst-to-address-list address-list="Suspected SMURF Attacks" \
    address-list-timeout=none-dynamic chain="RFC ICMP Protection" comment=\
    "Detect Suspected SMURF Attacks" dst-address-type=broadcast log=yes \
    log-prefix="FW-SMURF Attacks" protocol=icmp
add action=drop chain="RFC ICMP Protection" comment=\
    "Drop Suspected SMURF Attacks" dst-address-list="Suspected SMURF Attacks" \
    protocol=icmp
add action=accept chain="RFC ICMP Protection" comment="Accept Echo Requests" \
    icmp-options=8:0 protocol=icmp
add action=accept chain="RFC ICMP Protection" comment="Accept Echo Replys" \
    icmp-options=0:0 protocol=icmp
add action=accept chain="RFC ICMP Protection" comment=\
    "Accept Destination Network Unreachable" icmp-options=3:0 protocol=icmp
add action=accept chain="RFC ICMP Protection" comment=\
    "Accept Destination Host Unreachable" icmp-options=3:1 protocol=icmp
add action=accept chain="RFC ICMP Protection" comment=\
    "Accept Destination Port Unreachable" icmp-options=3:3 protocol=icmp
add action=accept chain="RFC ICMP Protection" comment=\
    "Fragmentation Messages" icmp-options=3:4 protocol=icmp
add action=accept chain="RFC ICMP Protection" comment="Source Route Failed" \
    icmp-options=3:5 protocol=icmp
add action=accept chain="RFC ICMP Protection" comment=\
    "Network Admin Prohibited" icmp-options=3:9 protocol=icmp
add action=accept chain="RFC ICMP Protection" comment="Host Admin Prohibited" \
    icmp-options=3:10 protocol=icmp
add action=accept chain="RFC ICMP Protection" comment="Router Advertisemnet" \
    icmp-options=9:0 protocol=icmp
add action=accept chain="RFC ICMP Protection" comment="Router Solicitation" \
    icmp-options=9:10 protocol=icmp
add action=accept chain="RFC ICMP Protection" comment="Time Exceeded" \
    icmp-options=11:0-1 protocol=icmp
add action=accept chain="RFC ICMP Protection" comment=Traceroute \
    icmp-options=30:0 protocol=icmp
add action=drop chain="RFC ICMP Protection" comment=\
    "Drop ALL other ICMP Messages" log=yes log-prefix="FW-ICMP Protection" \
    protocol=icmp
add action=jump chain=input comment="Jump to RFC Port Scans" jump-target=\
    "RFC Port Scans" protocol=tcp
add action=jump chain=input comment="Jump to RFC Port Scans" jump-target=\
    "RFC Port Scans" protocol=udp
add action=jump chain=forward comment="Jump to RFC Port Scans" jump-target=\
    "RFC Port Scans" protocol=tcp
add action=jump chain=forward comment="Jump to RFC Port Scans" jump-target=\
    "RFC Port Scans" protocol=udp
add action=drop chain="RFC Port Scans" comment=\
    "Drop anyone in the WAN Port Scanner List" src-address-list=\
    "WAN Port Scanners"
add action=drop chain="RFC Port Scans" comment=\
    "Drop anyone in the WAN Port Scanner List" dst-address-list=\
    "WAN Port Scanners"
add action=drop chain="RFC Port Scans" comment=\
    "Drop anyone in the LAN Port Scanner List" src-address-list=\
    "LAN Port Scanners"
add action=drop chain="RFC Port Scans" comment=\
    "Drop anyone in the LAN Port Scanner List" dst-address-list=\
    "LAN Port Scanners"
add action=return chain="RFC Port Scans" comment="Return from RFC Port Scans"
add action=drop chain=input comment="Block bad actors" src-address-list=\
    Blocked
add action=drop chain=forward comment="Drop any traffic going to bad actors" \
    dst-address-list=Blocked
/ip firewall mangle
add action=accept chain=prerouting comment=PCC dst-address=192.168.50.0/28
add action=accept chain=prerouting dst-address=192.168.1.0/24
add action=accept chain=prerouting dst-address=192.168.88.0/24
add action=accept chain=prerouting dst-address=10.0.50.0/24
add action=accept chain=prerouting dst-address=10.0.0.0/29
add action=accept chain=prerouting dst-address=192.168.0.0/24
add action=accept chain=prerouting dst-address=172.17.0.0/24
add action=mark-connection chain=input in-interface=ether2 \
    new-connection-mark=isp2 passthrough=yes
add action=mark-connection chain=input in-interface=ether1 \
    new-connection-mark=isp1 passthrough=yes
add action=mark-connection chain=prerouting in-interface=ether2 \
    new-connection-mark=isp2 passthrough=yes
add action=mark-connection chain=prerouting in-interface=ether1 \
    new-connection-mark=isp1 passthrough=yes
add action=mark-connection chain=prerouting dst-address-type=!local \
    in-interface=ether4 new-connection-mark=isp2 passthrough=yes \
    per-connection-classifier=both-addresses:2/0
add action=mark-connection chain=prerouting dst-address-type=!local \
    in-interface=ether3 new-connection-mark=isp2 passthrough=yes \
    per-connection-classifier=both-addresses:2/0
add action=mark-connection chain=prerouting dst-address-type=!local \
    in-interface=ether5 new-connection-mark=isp2 passthrough=yes \
    per-connection-classifier=both-addresses:2/0
add action=mark-connection chain=prerouting dst-address-type=!local \
    in-interface=ether4 new-connection-mark=isp1 passthrough=yes \
    per-connection-classifier=both-addresses:2/1
add action=mark-connection chain=prerouting dst-address-type=!local \
    in-interface=ether3 new-connection-mark=isp1 passthrough=yes \
    per-connection-classifier=both-addresses:2/1
add action=mark-connection chain=prerouting dst-address-type=!local \
    in-interface=ether5 new-connection-mark=isp1 passthrough=yes \
    per-connection-classifier=both-addresses:2/1
add action=mark-routing chain=output connection-mark=isp2 new-routing-mark=\
    to-isp2 passthrough=yes
add action=mark-routing chain=output connection-mark=isp1 new-routing-mark=\
    to-isp1 passthrough=yes
add action=mark-routing chain=prerouting connection-mark=isp2 in-interface=\
    ether4 new-routing-mark=to-isp2 passthrough=yes
add action=mark-routing chain=prerouting connection-mark=isp2 in-interface=\
    ether3 new-routing-mark=to-isp2 passthrough=yes
add action=mark-routing chain=prerouting connection-mark=isp2 in-interface=\
    ether5 new-routing-mark=to-isp2 passthrough=yes
add action=mark-routing chain=prerouting connection-mark=isp1 in-interface=\
    ether4 new-routing-mark=to-isp1 passthrough=yes
add action=mark-routing chain=prerouting connection-mark=isp1 in-interface=\
    ether3 new-routing-mark=to-isp1 passthrough=yes
add action=mark-routing chain=prerouting connection-mark=isp1 in-interface=\
    ether5 new-routing-mark=to-isp1 passthrough=yes
add action=change-mss chain=forward comment="Internet MSS Changing" new-mss=\
    clamp-to-pmtu out-interface=ether2 passthrough=yes protocol=tcp \
    tcp-flags=syn tcp-mss=1453-65535
add action=change-mss chain=forward in-interface=ether2 new-mss=clamp-to-pmtu \
    passthrough=yes protocol=tcp tcp-flags=syn tcp-mss=1453-65535
add action=change-mss chain=forward comment="Internet MSS Changing" new-mss=\
    clamp-to-pmtu out-interface=ether1 passthrough=yes protocol=tcp \
    tcp-flags=syn tcp-mss=1453-65535
add action=change-mss chain=forward in-interface=ether1 new-mss=clamp-to-pmtu \
    passthrough=yes protocol=tcp tcp-flags=syn tcp-mss=1453-65535
add action=change-mss chain=forward comment="Internet MSS Changing" new-mss=\
    clamp-to-pmtu out-interface=ether4 passthrough=yes protocol=tcp \
    tcp-flags=syn tcp-mss=1453-65535
add action=change-mss chain=forward in-interface=ether4 new-mss=clamp-to-pmtu \
    passthrough=yes protocol=tcp tcp-flags=syn tcp-mss=1453-65535
add action=change-dscp chain=prerouting comment=\
    "Transfer L2 QoS (Priority) value of 7 to L3 QoS (TOS/DSCP) value of 7" \
    new-dscp=7 passthrough=yes priority=7
add action=change-dscp chain=prerouting comment=\
    "Transfer L2 QoS (Priority) value of 6 to L3 QoS (TOS/DSCP) value of 6" \
    new-dscp=6 passthrough=yes priority=6
add action=change-dscp chain=prerouting comment=\
    "Transfer L2 QoS (Priority) value of 5 to L3 QoS (TOS/DSCP) value of 5" \
    new-dscp=5 passthrough=yes priority=5
add action=change-dscp chain=prerouting comment=\
    "Transfer L2 QoS (Priority) value of 4 to L3 QoS (TOS/DSCP) value of 4" \
    new-dscp=4 passthrough=yes priority=4
add action=change-dscp chain=prerouting comment=\
    "Transfer L2 QoS (Priority) value of 3 to L3 QoS (TOS/DSCP) value of 3" \
    new-dscp=3 passthrough=yes priority=3
add action=change-dscp chain=prerouting comment=\
    "Transfer L2 QoS (Priority) value of 2 to L3 QoS (TOS/DSCP) value of 2" \
    new-dscp=2 passthrough=yes priority=2
add action=change-dscp chain=prerouting comment=\
    "Transfer L2 QoS (Priority) value of 1 to L3 QoS (TOS/DSCP) value of 1" \
    new-dscp=1 passthrough=yes priority=1
add action=change-dscp chain=prerouting comment=\
    "Transfer L2 QoS (Priority) value of 0 to L3 QoS (TOS/DSCP) value of 0" \
    new-dscp=0 passthrough=yes priority=0
add action=set-priority chain=prerouting comment=\
    "Transfer L3 QoS (ToS/DSCP) value of 7 to L2 QoS (Priority) value of 7" \
    dscp=7 new-priority=7 passthrough=yes
add action=set-priority chain=prerouting comment=\
    "Transfer L3 QoS (ToS/DSCP) value of 6 to L2 QoS (Priority) value of 6" \
    dscp=6 new-priority=6 passthrough=yes
add action=set-priority chain=prerouting comment=\
    "Transfer L3 QoS (ToS/DSCP) value of 5 to L2 QoS (Priority) value of 5" \
    dscp=5 new-priority=5 passthrough=yes
add action=set-priority chain=prerouting comment=\
    "Transfer L3 QoS (ToS/DSCP) value of 4 to L2 QoS (Priority) value of 4" \
    dscp=4 new-priority=4 passthrough=yes
add action=set-priority chain=prerouting comment=\
    "Transfer L3 QoS (ToS/DSCP) value of 3 to L2 QoS (Priority) value of 3" \
    dscp=3 new-priority=3 passthrough=yes
add action=set-priority chain=prerouting comment=\
    "Transfer L3 QoS (ToS/DSCP) value of 2 to L2 QoS (Priority) value of 2" \
    dscp=2 new-priority=2 passthrough=yes
add action=set-priority chain=prerouting comment=\
    "Transfer L3 QoS (ToS/DSCP) value of 1 to L2 QoS (Priority) value of 1" \
    dscp=1 new-priority=1 passthrough=yes
add action=set-priority chain=prerouting comment=\
    "Transfer L3 QoS (ToS/DSCP) value of 0 to L2 QoS (Priority) value of 0" \
    dscp=0 new-priority=0 passthrough=yes
add action=mark-packet chain=prerouting comment="By Pass Ping From Shapping" \
    new-packet-mark=Ping_in passthrough=yes protocol=icmp
add action=mark-packet chain=postrouting new-packet-mark=Ping_out \
    passthrough=yes protocol=icmp
add action=change-ttl chain=postrouting dst-address=192.168.50.4/31 new-ttl=\
    set:64 out-interface=ether4 passthrough=yes protocol=icmp
add action=change-ttl chain=postrouting dst-address=192.168.50.4/31 new-ttl=\
    set:64 out-interface=ether4 passthrough=yes protocol=udp
add action=change-ttl chain=postrouting dst-address=192.168.50.8 new-ttl=\
    set:255 out-interface=ether4 passthrough=yes protocol=tcp
add action=set-priority chain=postrouting comment="UDP DNS & mDNS Requests" \
    new-priority=6 passthrough=yes port=53,5353 protocol=udp
add action=change-dscp chain=postrouting new-dscp=46 passthrough=yes port=\
    53,5353 protocol=udp
add action=change-dscp chain=postrouting new-dscp=34 passthrough=yes port=\
    53,5353 protocol=udp
add action=change-dscp chain=postrouting new-dscp=18 passthrough=yes port=\
    53,5353 protocol=udp
add action=change-ttl chain=postrouting new-ttl=set:55 out-interface=ether1 \
    passthrough=yes port=53,5353 protocol=udp
add action=change-ttl chain=postrouting new-ttl=set:55 out-interface=ether2 \
    passthrough=yes port=53,5353 protocol=udp
add action=change-dscp chain=prerouting comment="DHCP DSCP" new-dscp=25 \
    passthrough=yes port=67-68 protocol=udp
add action=change-dscp chain=prerouting new-dscp=25 passthrough=yes port=\
    67-68 protocol=tcp
add action=accept chain=output comment="Section Break"
add action=mark-connection chain=prerouting comment="USUAL DOMAINS" \
    new-connection-mark=game-cm passthrough=yes src-address-list=vpnize-auto
add action=mark-connection chain=prerouting comment="USUAL DOMAINS" \
    dst-address-list=vpnize-auto new-connection-mark=game-cm passthrough=yes
add action=mark-connection chain=prerouting comment="Mobile Legends" \
    new-connection-mark=game-cm passthrough=yes port=\
    5000-5200,5230-5508,5551-5558,5601-5608,5651-5658,30097-30147 protocol=\
    tcp
add action=mark-connection chain=prerouting comment="ONLINE GAME PORTS" \
    new-connection-mark=game-cm passthrough=yes port=\
    5340-5352,6000-6152,10001-10011,14009-14030,18901-18909 protocol=tcp
add action=mark-connection chain=prerouting new-connection-mark=game-cm \
    passthrough=yes port=\
    39190,27780,29000,22100,10009,4300,15001,15002,7341,7451 protocol=tcp
add action=mark-connection chain=prerouting new-connection-mark=game-cm \
    passthrough=yes port=40000,9300,9400,9700,7342,8005-8010,37466,36567,8822 \
    protocol=tcp
add action=mark-connection chain=prerouting new-connection-mark=game-cm \
    passthrough=yes port=47611,16666,20000,5105,29000,18901-18909,9015 \
    protocol=tcp
add action=mark-connection chain=prerouting comment="Facebook Games" \
    new-connection-mark=game-cm passthrough=yes port=9339 protocol=tcp
add action=mark-connection chain=prerouting comment="League Of Legends" \
    new-connection-mark=game-cm passthrough=yes port=8393-8400,2099,5222-5223 \
    protocol=tcp
add action=mark-connection chain=prerouting new-connection-mark=game-cm \
    passthrough=yes port=20466,9100,21033 protocol=tcp
add action=mark-connection chain=prerouting new-connection-mark=game-cm \
    passthrough=yes port=20466,9100,21033 protocol=udp
add action=mark-connection chain=prerouting new-connection-mark=game-cm \
    passthrough=yes port=5000-5500 protocol=udp
add action=mark-connection chain=prerouting comment="DOTA2 and Steam" \
    new-connection-mark=game-cm passthrough=no port=27015-28999 protocol=udp
add action=mark-connection chain=prerouting new-connection-mark=game-cm \
    passthrough=yes port=27000-27020,13055,7800-7900,12060-12070 protocol=udp
add action=mark-connection chain=prerouting new-connection-mark=game-cm \
    passthrough=yes port=8005-8010,9068,1293,1479,9401,9600,30000 protocol=\
    udp
add action=mark-connection chain=prerouting new-connection-mark=game-cm \
    passthrough=yes port=14009-14030,42051-42052,40000-40050,13000-13080 \
    protocol=udp
add action=mark-connection chain=prerouting new-connection-mark=game-cm \
    passthrough=yes port=16666,9110,13006,10008 protocol=udp
add action=mark-connection chain=prerouting new-connection-mark=game-cm \
    passthrough=yes port=1512-1515,6112-6119,4000-4200 protocol=udp
add action=mark-connection chain=prerouting comment="Soldier Front" \
    new-connection-mark=game-cm passthrough=yes port=22001-22999 protocol=udp
add action=mark-connection chain=prerouting new-connection-mark=game-cm \
    passthrough=yes port=27230-27235 protocol=tcp
add action=mark-connection chain=prerouting new-connection-mark=game-cm \
    passthrough=yes port=1119,3724,6113 protocol=tcp
add action=change-dscp chain=postrouting comment="game priority" \
    connection-mark=game-cm new-dscp=6 passthrough=yes
add action=change-dscp chain=postrouting connection-mark=game-cm new-dscp=25 \
    passthrough=yes
add action=change-dscp chain=postrouting connection-mark=game-cm new-dscp=26 \
    passthrough=yes
add action=change-dscp chain=postrouting connection-mark=game-cm new-dscp=28 \
    passthrough=yes
add action=change-dscp chain=postrouting connection-mark=game-cm new-dscp=30 \
    passthrough=yes
add action=change-dscp chain=postrouting connection-mark=game-cm new-dscp=46 \
    passthrough=yes
add action=change-dscp chain=postrouting connection-mark=game-cm new-dscp=48 \
    passthrough=yes
add action=change-dscp chain=postrouting connection-mark=game-cm new-dscp=56 \
    passthrough=yes
add action=change-ttl chain=postrouting comment="GAME TTL" connection-mark=\
    game-cm new-ttl=set:64 out-interface=ether1 passthrough=yes protocol=tcp
add action=change-ttl chain=postrouting connection-mark=game-cm new-ttl=\
    set:64 out-interface=ether2 passthrough=yes protocol=tcp
add action=change-ttl chain=postrouting connection-mark=game-cm new-ttl=\
    set:65 out-interface=ether1 passthrough=yes protocol=udp
add action=change-ttl chain=postrouting connection-mark=game-cm new-ttl=\
    set:65 out-interface=ether2 passthrough=yes protocol=udp
add action=change-ttl chain=postrouting connection-mark=game-cm new-ttl=\
    set:65 out-interface=ether1 passthrough=yes protocol=icmp
add action=change-ttl chain=postrouting connection-mark=game-cm new-ttl=\
    set:65 out-interface=ether2 passthrough=yes protocol=icmp
add action=mark-routing chain=prerouting comment=DNS dst-port=53 \
    in-interface=ether3 new-routing-mark=dns_route passthrough=no protocol=\
    udp
add action=mark-routing chain=prerouting comment="CACHE ROUTE" dst-port=80 \
    in-interface=ether3 new-routing-mark=raptor_route passthrough=no \
    protocol=tcp
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1
add action=masquerade chain=srcnat out-interface=ether2
/ip firewall raw
add action=jump chain=prerouting comment="Jump to Virus Chain" jump-target=\
    Virus protocol=tcp
add action=jump chain=prerouting comment="Jump to Virus Chain" jump-target=\
    Virus protocol=udp
add action=drop chain=Virus comment=Conficker dst-port=593 protocol=tcp
add action=drop chain=Virus comment=Worm dst-port=1024-1030 protocol=tcp
add action=drop chain=Virus comment="ndm requester" dst-port=1363 protocol=\
    tcp
add action=drop chain=Virus comment="ndm server" dst-port=1364 protocol=tcp
add action=drop chain=Virus comment="screen cast" dst-port=1368 protocol=tcp
add action=drop chain=Virus comment=hromgrafx dst-port=1373 protocol=tcp
add action=drop chain=Virus comment="Drop MyDoom" dst-port=1080 protocol=tcp
add action=drop chain=Virus comment=cichlid dst-port=1377 protocol=tcp
add action=drop chain=Virus comment=Worm dst-port=1433-1434 protocol=tcp
add action=drop chain=Virus comment="Drop Dumaru.Y" dst-port=2283 protocol=\
    tcp
add action=drop chain=Virus comment="Drop Beagle" dst-port=2535 protocol=tcp
add action=drop chain=Virus comment="Drop Beagle.C-K" dst-port=2745 protocol=\
    tcp
add action=drop chain=Virus comment="Drop Backdoor OptixPro" dst-port=3410 \
    protocol=tcp
add action=drop chain=Virus comment="Drop Sasser" dst-port=5554 protocol=tcp
add action=drop chain=Virus comment=Worm dst-port=4444 protocol=tcp
add action=drop chain=Virus comment=Worm dst-port=4444 protocol=udp
add action=drop chain=Virus comment="Drop Beagle.B" dst-port=8866 protocol=\
    tcp
add action=drop chain=Virus comment="Drop Dabber.A-B" dst-port=9898 protocol=\
    tcp
add action=drop chain=Virus comment="Drop SubSeven" dst-port=27374 protocol=\
    tcp
add action=drop chain=Virus comment="Drop PhatBot, Agobot, Gaobot" dst-port=\
    65506 protocol=tcp
add action=return chain=Virus comment="Return From Virus Chain"
/ip proxy
set parent-proxy=0.0.0.0
/ip route
add check-gateway=ping distance=1 gateway=8.8.8.8 routing-mark=to-isp2
add check-gateway=ping distance=1 gateway=1.1.1.1 routing-mark=to-isp1
add check-gateway=ping distance=1 gateway=192.168.50.5,192.168.50.4 \
    routing-mark=dns_route
add check-gateway=ping distance=3 gateway=192.168.50.8 routing-mark=\
    raptor_route
add check-gateway=ping distance=1 gateway=8.8.8.8
add check-gateway=ping distance=2 gateway=1.1.1.1
add check-gateway=ping distance=1 dst-address=1.1.1.1/32 gateway=192.168.88.1 \
    scope=10
add check-gateway=ping distance=1 dst-address=8.8.8.8/32 gateway=192.168.1.1 \
    scope=10
add distance=1 dst-address=172.17.0.0/24 gateway=10.0.0.2
add distance=1 dst-address=192.168.0.0/24 gateway=10.0.0.2
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes
set ssh address=192.168.50.0/28
set api address=192.168.50.0/28
set winbox address=10.0.50.0/24,192.168.50.0/28
set api-ssl disabled=yes
/ip ssh
set allow-none-crypto=yes forwarding-enabled=remote
/snmp
set trap-target=192.168.50.6 trap-version=2
/system clock
set time-zone-name=Asia/Manila
/system identity
set name=JERIC-DOMAIN
/system logging
set 0 action=echo
set 1 action=echo
set 2 action=echo
add action=echo prefix=-> topics=info,debug
/system ntp client
set enabled=yes primary-ntp=162.159.200.1 secondary-ntp=110.170.126.102
/system package update
set channel=long-term
/system scheduler
add interval=30m name="add list" on-event=add-list policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-time=startup
/system script
add dont-require-permissions=no name=add-list owner=admin policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="#\
    \_ASN bazinda VPN scripti\r\
    \n# 2018 Hazar\r\
    \n\r\
    \n:local VPNAddrList \"vpnize-auto\";\r\
    \n\r\
    \n:local ASNlist {\r\
    \n                 AS17394=\"NETAPP\"\r\
    \n\tAS13335=\"ML\"\r\
    \n\tAS16625=\"ML\"\r\
    \n\tAS37963=\"ML\"\r\
    \n                 AS20940=\"ML\"\r\
    \n\tAS6507=\"RIOT GAMES\"\r\
    \n\tAS38118=\"RIOT GAMES\"\r\
    \n\tAS2914=\"Akamai\"\r\
    \n    AS16509=\"Amazon\"\r\
    \n\tAS13335=\"Cloudflare\";\r\
    \n\tAS9299=\"Akamai\";\r\
    \n\tAS6432=\"google\";\t \r\
    \n\tAS55023=\"google\"; \r\
    \n\tAS45566=\"google\";\r\
    \n\tAS43515=\"google\";\r\
    \n\tAS41264=\"google\";\r\
    \n\tAS40873=\"google\";\r\
    \n\tAS396982=\"google\"; \r\
    \n\tAS395973=\"google\";\r\
    \n\tAS394699=\"google\";\r\
    \n\tAS394639=\"google\";\r\
    \n\tAS394507=\"google\";\r\
    \n\tAS36987=\"google\";\r\
    \n\tAS36492=\"google\";\r\
    \n\tAS36385=\"google\";\r\
    \n\tAS36384=\"google\";\r\
    \n\tAS36040=\"google\";\r\
    \n\tAS36039=\"google\";\r\
    \n\tAS26910=\"google\";\r\
    \n\tAS26684=\"google\";\r\
    \n\tAS22859=\"google\";\r\
    \n\tAS22577=\"google\";\r\
    \n\tAS19527=\"google\";\r\
    \n\tAS19448=\"google\";\r\
    \n\tAS19425=\"google\";\r\
    \n\tAS16591=\"google\";\r\
    \n\tAS16550=\"google\";\r\
    \n\tAS15169=\"google\";\r\
    \n\tAS13949=\"google\";\r\
    \n\tAS139190=\"google\"; \r\
    \n\tAS139070=\"google\";\r\
    \n\tAS16625=\"akamai\";\r\
    \n                AS20940=\"akamai\";\r\
    \n                AS54994=\"ML\";\r\
    \n}\r\
    \n\r\
    \n:log info \"VPN icin ASN update basliyor.\";\r\
    \n/system logging disable 0;\r\
    \n\r\
    \n# Temizlik.\r\
    \n/ip firewall address-list remove [find list=\$VPNAddrList];\r\
    \n\r\
    \n:foreach asn,com in=\$ASNlist do={\t\r\
    \n\t/tool fetch url=(\"https://www.enjen.net/asn-blocklist/index.php\?asn=\
    AS\" . \$asn . \"&type=iplist&api=1\") dst-path=(\"AS\" . \$asn . \".txt\"\
    );\r\
    \n\t:put (\"AS\" . \$asn . \".txt\");\r\
    \n\t\r\
    \n\tif ([:len [/file find name=(\"AS\" . \$asn . \".txt\")]] > 0) do={\r\
    \n\t\t:local content [/file get [/file find name=(\"AS\" . \$asn . \".txt\
    \")] contents] ;\r\
    \n\t\t:local contentLen [ :len \$content ] ;\r\
    \n\r\
    \n\t\t:local lineEnd 0;\r\
    \n\t\t:local line \"\";\r\
    \n\t\t:local lastEnd 0;\r\
    \n\t\t\r\
    \n\t\t:do {\r\
    \n\t\t\t:set lineEnd [:find \$content \"\\n\" \$lastEnd ];\r\
    \n\t\t\t:set line [:pick \$content \$lastEnd \$lineEnd];\r\
    \n\t\t\t:set lastEnd ( \$lineEnd + 1 );\r\
    \n\t\t\t\r\
    \n\t\t\t:if (\$line != \"\") do={\t\t\t\t\r\
    \n\t\t\t\t/do {ip firewall address-list add list=\$VPNAddrList address=\$l\
    ine comment=(\"ASNVPN Script: \" . \$com);} on-error={}\r\
    \n\t\t\t}\r\
    \n\t\t\t\r\
    \n\t\t\t:put (\$com . \": \" . \$line);\r\
    \n\t\t\t\r\
    \n\t\t} while (\$lastEnd < \$contentLen);\r\
    \n\t\t\r\
    \n\t\t# Temizlik\r\
    \n\t\t#/file remove (\"AS\" . \$asn . \".txt\");\r\
    \n\t} else={\r\
    \n\t\t:put (\"AS\" . \$asn . \" route detayi alinamadi.\");\r\
    \n\t}\r\
    \n}\r\
    \n\r\
    \n/system logging enable 0;\r\
    \n:log info \"VPN icin ASN update tamamlandi.\";"
/tool sniffer
set filter-cpu=2 filter-interface=ether1,ether2 filter-stream=yes \
    streaming-enabled=yes streaming-server=192.168.50.7
