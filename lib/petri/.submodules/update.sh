#!/bin/sh

rm -f *.ml

find ../[a-z]* -name "*.ml" -type f \
  | grep "/.*/" \
  | sed -r 's,^../,,' \
  | sort \
  | awk -F / \
'{
   printf("ln -sf ../%s %s",$0,$1)
   for (i = 2; i <= NF; i++) {
     printf("__%s%s",toupper(substr($i,1,1)),substr($i,2))
   }
   printf("\n")
 }' | sh

rm -f *__.ml

find ../[a-z]* -name "*.ml" -type f \
  | grep "/.*/" \
  | sed -r 's,^../,,;s,\.ml$,,' \
  | sort \
  | awk -F / \
'{
   printf("echo module %s%s = ",toupper(substr($NF,1,1)),substr($NF,2))
   printf("%s%s",toupper(substr($1,1,1)),substr($1,2))
   for (i = 2; i <= NF; i++) {
     printf("__%s%s",toupper(substr($i,1,1)),substr($i,2))
   }
   printf(" >> ")
   printf("%s",$1)
   for (i = 2; i <= NF-1; i++) {
     printf("__%s%s",toupper(substr($i,1,1)),substr($i,2))
   }
   printf("__.ml\n")

 }' | sh

for a in *__.ml; do
 b=`echo $a | sed 's,__\.ml$,.ml,'`
 if [ ! -f ../$b -a ! -f $b ]; then
   ln -sf $a $b
 fi
done
