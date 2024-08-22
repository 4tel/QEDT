declare -A List

List[0,1]=1
List[0,2]=2
List[1,1]=3
List[2,1]=4
List[0]=(1 2 3)
a=(1 2 3)

for idx in {0..2};do
for jdx in {0..2};do
 echo \($idx, $jdx\): ${List[$idx,$jdx]}
done
done
echo ${List[0]}
echo $a
