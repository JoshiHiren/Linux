echo "Enter First Number:- "
read no1 
echo "Enter Second Number:-"
read no2
echo "Enter Third Number:-"
read no3

if [ $no1 -gt $no2 ] && [ $no1 -gt $no3 ]
then
	echo "No1 is largest number: $no1"
elif [ $no2 -gt $no1 ] && [ $no2 -gt $no3 ]
then
	echo "No2 is largest number: $no2"
else
	echo "No3 is largest number: $no3"
fi


