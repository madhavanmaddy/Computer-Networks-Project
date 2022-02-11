set val(chan) Channel/WirelessChannel ;
set val(prop) Propagation/TwoRayGround ;
set val(netif) Phy/WirelessPhy ;
set val(mac) Mac/802_11 ;
set val(ifq) Queue/DropTail/PriQueue ;
set val(ll) LL ;
set val(ant) Antenna/OmniAntenna ;
set val(ifqlen) 50 ;
puts "Enter the Number of Nodes : "
gets stdin val(nn)
set val(rp) AODV ;
set val(x) 956 ;
set val(y) 600 ;
set val(stop) 25.0 ;
set val(pktsize) 2000;
set ns [new Simulator]
set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)
create-god $val(nn)
set tracefile [open MANET.tr w]
$ns trace-all $tracefile
set namfile [open MANET.nam w]
$ns namtrace-all $namfile
$ns namtrace-all-wireless $namfile $val(x) $val(y)
set chan [new $val(chan)];
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
for {set i 0} {$i < $val(nn) } { incr i } {
	set n($i) [$ns node]
	$n($i) set X_ [expr {int(rand() * 600)}]
	$n($i) set Y_ [expr {int(rand() * 600)}]
	$n($i) set Z_ 0.0
	$ns initial_node_pos $n($i) 20
}
for {set i 0} {$i < $val(nn) } { incr i } {
	set x [expr {int(rand() * 600)}]
	set y [expr {int(rand() * 600)}]
	set z [expr {int(rand() * 20)}]
$ns at [expr $i + 1 ] " $n($i) setdest $x $y $z "
	set x [expr {int(rand() * 600)}]
	set y [expr {int(rand() * 600)}]
	set z [expr {int(rand() * 20)}]
$ns at [expr $i + 1 * 5 ] " $n($i) setdest $x $y $z " 	
}
set a [expr {int(rand() * 5)}]
set b [expr {int( $val(nn) - $a)}]
#TCP connection 1
set tcp0 [new Agent/TCP]
$ns attach-agent $n($a) $tcp0
set sink2 [new Agent/TCPSink]
$ns attach-agent $n($b) $sink2
$ns connect $tcp0 $sink2
$tcp0 set packetSize_ 2000
set p [expr {int(rand() * 15)}]
set q [expr {int( $val(nn) - $p)}]
#TCP connection 2
set tcp1 [new Agent/TCP]
$ns attach-agent $n($p) $tcp1
set sink3 [new Agent/TCPSink]
$ns attach-agent $n($q) $sink3
$ns connect $tcp1 $sink3
$tcp1 set packetSize_ 2000
#FTP Application over TCP connection 1
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ns at 1.0 "$ftp0 start"
$ns at 15.0 "$ftp0 stop"
#FTP Application over TCP connection 2
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ns at 15.0 "$ftp1 start"
$ns at 15.0 "$ftp1 stop"
proc finish {} {
 global ns tracefile namfile
 $ns flush-trace
 close $tracefile
 close $namfile
 exec nam MANET.nam &
exec awk -f e2edelay.awk MANET.tr &
exec awk -f pdf.awk MANET.tr &
exec awk -f throughput.awk MANET.tr &
exit 0
}
for {set i 0} {$i < $val(nn) } { incr i } {
 $ns at $val(stop) "\$n($i) reset"
}
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" ; $ns halt"
$ns run