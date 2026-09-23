echo "Enter a Number :- "
read num

if [ $num -gt 0 ]
then
echo "Number is Positive"
elif [ $num -lt 0 ]
then
echo "Number is Negative"
else
echo "Number is Zero"
fi

if [ $((num%2)) -eq 0 ]
then
echo "Number is Even"
else
echo "Number is Odd"
fi
