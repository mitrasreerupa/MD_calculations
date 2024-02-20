#to extract bond lengths, bond angles and the main chain dihedrals 
#Calculation of bond angle:
################################################
open (G ,"diala.sd") or die "FNF\n";
open (W,">bond_angles.txt") or die "FNF\n";
open (T,">out1.txt") or die "FNF\n";
while (chomp($line=<G>))
{
 if ($line=~/\s+(\S+)\s+(\S+)\s+(\S+)\s+([A-Z])(\s+)\S+/)
 {
 #print"$line\n";
 push @x ,$1;push @y ,$2;push @z ,$3;push @na ,$4;}
 elsif ($line=~/^(\s+([0-9]+)\s+([0-9]+)\s+([0-9])\s+(0)\s+(0)\s+(0))$/)
 	{
# print"$line\n";
 push @c1 ,$2;
 push @c2 ,$3;
 	}
}
$len=@c1;
#print"$len";
#print"@c1\n";
unshift@x,"";
unshift@y,"";
unshift@z,"";
unshift@na,"";
#print"@x\n";+[0-9]\s+[0-9]\s+[0-9]\s+[0-9]
#print"@c1\n";

foreach $i(0..$len-1)
{
foreach $j($i+1..$len-1)
	{
		if (@c1[$i] == @c2[$j])
		{
		#print"1:::	@c1[$i]:$i	@c2[$i]:$i\n1:::	@c1[$j]:$j	@c2[$j]:$j\n\n";
		$count1++;
		push @k1 ,@c2[$i];  push @k2 ,@c1[$i];  push @k3 ,@c1[$j];
		}
		if (@c2[$i] == @c1[$j])
		{
		#print"2:::	@c1[$i]:$i	@c2[$i]:$i\n2:::	@c1[$j]:$j	@c2[$j]:$j\n\n";
		$count2++;
		push @k1 ,@c1[$i] ; push @k2 ,@c2[$i] ; push @k3 ,@c2[$j];
		}
		if (@c1[$i] == @c1[$j])
		{
		#print"3:::	@c1[$i]:$i	@c2[$i]:$i\n3:::	@c1[$j]:$j	@c2[$j]:$j\n\n";
		$count3++;
		push @k1 ,@c2[$i] ; push @k2 ,@c1[$i] ; push @k3 ,@c2[$j];
		}
		if (@c2[$i] == @c2[$j])
		{
		#print"4:::	@c1[$i]:$i	@c2[$i]:$i\n4:::	@c1[$j]:$j	@c2[$j]:$j\n\n";
		$count4++;
		push @k1 ,@c1[$i] ; push @k2 ,@c2[$i] ; push @k3 ,@c1[$j] ;
		}
	}
}
#print"$count1 and $count2 and $count3 and $count4\n";
#print"k1=@k1\nk2=@k2\nk3=@k3\n";

$len1 = @k1;
#print"$len1\n";
##distance between atom k1 to k2 is $aa
##distance between atom k2 to k3 is $bb
##distance between atom k1 to k3 is $cc

foreach $a (0..$len1-1)
{
$aa = sqrt((@x[@k1[$a]]-@x[@k2[$a]])**2+(@y[@k1[$a]]-@y[@k2[$a]])**2+(@z[@k1[$a]]-@z[@k2[$a]])**2);
push @aa1 ,$aa; 
#print"$aa and $a\n";
$bb = sqrt((@x[@k2[$a]]-@x[@k3[$a]])**2+(@y[@k2[$a]]-@y[@k3[$a]])**2+(@z[@k2[$a]]-@z[@k3[$a]])**2);
push @bb1 ,$bb;
$cc = sqrt((@x[@k1[$a]]-@x[@k3[$a]])**2+(@y[@k1[$a]]-@y[@k3[$a]])**2+(@z[@k1[$a]]-@z[@k3[$a]])**2);
push @cc1 ,$cc;
}

use Math::Trig ;
$len2 =@aa1 ;
foreach $q (0..$len2-1)
{
$s = acos ( ( ( ((@aa1[$q])**2 + (@bb1[$q])**2 ) - (@cc1[$q])**2) ) / (2 * @aa1[$q] * @bb1[$q] ));
$final=rad2deg ($s);
print W "$q: 	Angle is $final :	@k1[$q] - @k2[$q] -@k3[$q]\n";
print T "@k1[$q]\t@k2[$q]\t@k3[$q]\n";
print"Angles printed in file bond_angles.txt\n";
}


