BEGIN{
recvdSize=0
startTime=400
stopTime=0
}
{
event=$1
time=$2
node_id=$3
pkt_size=$8
level=$4
if((level=="AGT"||level=="IFQ") && (event=="s") && pkt_size>=512)
{
if(time<startTime)
{
 startTime=time
}
}
if((level=="AGT"||level=="IFQ") && (event=="r") && pkt_size>=512)
{
if(time>stopTime)
{
 stopTime=time
}
recvdSize+=pkt_size
}
}
END {
printf("Average Throughput[kbps]=%.9f\t\tStartTime =%.2f\tStopTime=%.2f\n",(recvdSize/(stopTime-startTime))*(8/1000),startTime,stopTime);
}