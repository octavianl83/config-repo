yourfilenames=`ls *.grl`

for filename in $yourfilenames
do
    redis-cli -x set $filename < $filename
done

redis-cli -x set process-config < process-config.json
redis-cli -x set simulator-config < simulator-config.json

declare -a arr=("volpay.instruction.receive" "volpay.sanctions.receive" "volpay.accountlookup.receive" "volpay.fundscontrol.receive" "volpay.rtp-accountposting.receive" "volpay.rtp-transmit-ack.receive" "volpay.sanctions.send" "volpay.accountlookup.send" "volpay.fundscontrol.send" "volpay.rtp-accountposting.send" "volpay.rtp-transmit.send" "volpay.rtp-transmit.receive" "volpay.payment.commitlog")

for i in "${arr[@]}"
do
    kafka-topics --create --topic $i --bootstrap-server localhost:29092
done


