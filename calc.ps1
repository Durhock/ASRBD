try {

write-host "entrez un nombre"
[int]$nbr1 =  read-host 

} catch {
echo "moi pas comprendre les lettres"


echo $nbr1
}


write-host "operateur : + ; - ; / ; *"
$op =  read-host


try {

write-host "entrez un nombre"
[int]$nbr2 =  read-host 

} catch {
echo "moi pas comprendre les lettres"


echo $nbr2
}




#la variabl est a CASTER des le début
#[int]$nbr1
#[int]$nbr2


 switch ($op){

 "+" {$res = $nbr1 + $nbr2}
 "-" {$res = $nbr1 - $nbr2 }
 "*" {$res =$nbr1 * $nbr2 }  
 "/" {$res =$nbr1 / $nbr2 }
    
    }



Write-Output " le resultat est :" $res
