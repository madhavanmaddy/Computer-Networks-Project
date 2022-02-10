BEGIN {
recvdSize = 0
startTime = 0.5
stopTime = 5.0
}
{
event = $1
time = $2
node_id = $3
pkt_size = $6
level = $4
# Store start time
if (event == "s") {
if (time < startTime) {
startTime = time
}
}
# Update total received packets' size and store packets arrival time
if (event == "r") {
if (time > stopTime) {
stopTime = time
}
recvdSize += pkt_size
}
}
END {
printf("Average Throughput[kbps] = %.2f\n ",(recvdSize/(stopTime-startTime))*(8/1000))
}
