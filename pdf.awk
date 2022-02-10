BEGIN{
packetssent =0;
packetsrecieved =0;
}
$0~/^s.* AGT/{
packetssent++;
}
$0~/^r.* AGT/{
packetsrecieved++;
}
END{
printf("sentPackets:%d\nrecievedPackets:%d\nPacket delivery Ratio:%.4f\n",packetssent,packetsrecieved,(packetsrecieved/packetssent));}