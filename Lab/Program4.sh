echo "Enter 1 number:"
read x
echo "Enter 2 number:"
read y

add ()
{
	echo "addition: $(( x + y ))"
}
sub ()
{
	echo "substraction: $(( x - y ))"
}
mul ()
{
	echo "multificaation: $(( x * y ))"
}
div ()
{
	echo "divison: $(( x / y ))"
}
mod ()
{
	echo "moduls: $(( x % y ))"
}
add $x $y
sub $x $y
mul $x $y
div $x $y
mod $x $y
