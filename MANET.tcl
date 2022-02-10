set val(chan) Channel/WirelessChannel ;# channel type
set val(prop) Propagation/TwoRayGround ;# radio-propagation model
set val(netif) Phy/WirelessPhy ;# network interface type
set val(mac) Mac/802_11 ;# MAC type
set val(ifq) Queue/DropTail/PriQueue ;# interface queue type
set val(ll) LL ;# link layer type
set val(ant) Antenna/OmniAntenna ;# antenna model
set val(ifqlen) 50 ;# max packet in ifq
set val(nn) 5 ;
set val(rp) DSDV ;# routing protocol
 #for other protocols give set val(rp) DSDV/DSR
set val(x) 956 ;# X dimension of topography
set val(y) 600 ;# Y dimension of topography
set val(stop) 25.0 ;# time of simulation end
set ns [new Simulator]
#Setup topography object
set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)
create-god $val(nn)
#Open the NS trace file
set tracefile [open MANET.tr w]
$ns trace-all $tracefile
#Open the NAM trace file
set namfile [open MANET.nam w]
$ns namtrace-all $namfile
$ns namtrace-all-wireless $namfile $val(x) $val(y)
set chan [new $val(chan)];#Create wireless channel
$ns node-config -adhocRouting $val(rp) \
 -llType $val(ll) \
 -macType $val(mac) \
 -ifqType $val(ifq) \
 -ifqLen $val(ifqlen) \
 -antType $val(ant) \
 -propType $val(prop) \
 -phyType $val(netif) \
 -channel $chan \
 -topoInstance $topo \
 -agentTrace ON \
 -routerTrace ON \
 -macTrace ON \
 -movementTrace ON
set n0 [$ns node]
$n0 set X_ 447
$n0 set Y_ 199
$n0 set Z_ 0.0
$ns initial_node_pos $n0 20
set n1 [$ns node]
$n1 set X_ 410
$n1 set Y_ 361
$n1 set Z_ 0.0
$ns initial_node_pos $n1 20
set n2 [$ns node]
$n2 set X_ 286
$n2 set Y_ 363
$n2 set Z_ 0.0
$ns initial_node_pos $n2 20
set n3 [$ns node]
$n3 set X_ 281
$n3 set Y_ 210
$n3 set Z_ 0.0
$ns initial_node_pos $n3 20
$n3 color red
set n4 [$ns node]
$n4 set X_ 138
$n4 set Y_ 246
$n4 set Z_ 0.0
$ns initial_node_pos $n4 20
$n4 color red
# set n5 [$ns node]
# $n5 set X_ 141
# $n5 set Y_ 412
# $n5 set Z_ 0.0
# $ns initial_node_pos $n5 20
# set n6 [$ns node]
# $n6 set X_ 261
# $n6 set Y_ 498
# $n6 set Z_ 0.0
# $ns initial_node_pos $n6 20
# set n7 [$ns node]
# $n7 set X_ 418
# $n7 set Y_ 564
# $n7 set Z_ 0.0
# $ns initial_node_pos $n7 20
# set n8 [$ns node]
# $n8 set X_ 292
# $n8 set Y_ 609
# $n8 set Z_ 0.0
# $ns initial_node_pos $n8 20
# set n9 [$ns node]
# $n9 set X_ 115
# $n9 set Y_ 542
# $n9 set Z_ 0.0
# $ns initial_node_pos $n9 20
# set n10 [$ns node]
# $n10 set X_ 41
# $n10 set Y_ 370
# $n10 set Z_ 0.0
# $ns initial_node_pos $n10 20
# set n11 [$ns node]
# $n11 set X_ 156
# $n11 set Y_ 688
# $n11 set Z_ 0.0
# $ns initial_node_pos $n11 20
# set n12 [$ns node]
# $n12 color "green"
# $n12 set X_ 316
# $n12 set Y_ 758
# $n12 set Z_ 0.0
# $ns initial_node_pos $n12 20
# set n13 [$ns node]
# $n13 set X_ 428
# $n13 set Y_ 728
# $n13 set Z_ 0.0
# $ns initial_node_pos $n13 20
# set n14 [$ns node]
# $n14 set X_ 54
# $n14 set Y_ 695
# $n14 set Z_ 0.0
# $ns initial_node_pos $n14 20
# set n15 [$ns node]
# $n15 set X_ 21
# $n15 set Y_ 556
# $n15 set Z_ 0.0
# $ns initial_node_pos $n15 20
# set n16 [$ns node]
# $n16 set X_ 188
# $n16 set Y_ 856
# $n16 set Z_ 0.0
# $ns initial_node_pos $n16 20
# set n17 [$ns node]
# $n17 set X_ 596
# $n17 set Y_ 782
# $n17 set Z_ 0.0
# $ns initial_node_pos $n17 20
# set n18 [$ns node]
# $n18 set X_ 375
# $n18 set Y_ 928
# $n18 set Z_ 0.0
# $ns initial_node_pos $n18 20
# set n19 [$ns node]
# $n19 set X_ 456
# $n19 set Y_ 826
# $n19 set Z_ 0.0
# $ns initial_node_pos $n19 20
$ns at 1.0 " $n1 setdest 500 300 10 "
$ns at 10.0 " $n1 setdest 600 500 30 "
$ns at 2.0 " $n2 setdest 363 287 30 "
$ns at 8.0 " $n2 setdest 695 54 25 "
$ns at 3.0 " $n3 setdest 752 462 25 "
$ns at 15.0 " $n3 setdest 834 102 10 "
#Setup a TCP connection
set tcp0 [new Agent/TCP]
$ns attach-agent $n1 $tcp0
set sink2 [new Agent/TCPSink]
$ns attach-agent $n3 $sink2
$ns connect $tcp0 $sink2
$tcp0 set packetSize_ 3000
#Setup a TCP connection
set tcp1 [new Agent/TCP]
$ns attach-agent $n2 $tcp1
set sink3 [new Agent/TCPSink]
$ns attach-agent $n4 $sink3
$ns connect $tcp1 $sink3
$tcp1 set packetSize_ 3000
#Setup a FTP Application over TCP connection
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ns at 1.0 "$ftp0 start"
$ns at 15.0 "$ftp0 stop"
#Setup a FTP Application over TCP connection
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ns at 2.0 "$ftp1 start"
$ns at 20.0 "$ftp1 stop"
proc finish {} {
 global ns tracefile namfile
 $ns flush-trace
 close $tracefile
 close $namfile
 exec nam MANET.nam &
 exit 0
}
for {set i 0} {$i < $val(nn) } { incr i } {
 $ns at $val(stop) "\$n$i reset"
}
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" ; $ns halt"
$ns run