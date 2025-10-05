Antemir Andreea-Catalina - 314CA

TASK-1 -- SORTARI

- registrul 'esi' - folosit pentru a retine adresa vectorului in care sunt
retinute nodurile listei
- registrul 'ecx' - folosit drept index pentru parcurgerea acestui vector pentru
a gasi capul listei
- incepem prin a parcurge vectorul in eticheta 'find_head' folosinde ne de 'ecx'
ca index
- la fiecare iteratie salvam in registrul 'edx' valoarea nodului curent (node.val)
iar daca aceasta valoare este egala cu 1 inseamna ca am gasit capul listei
- daca dupa ce am facut toate cele 'n' (valoare aflata in [ebp + 8]) iteratii nu
gasim nodul cu valoarea cautata se sare la eticheta 'not_found' si se returneaza
NULL (0)
- dupa ce am gasit capul listei contnuam cu crearea legaturilor intre noduri in
ordine crescatoare
- salval adresa nodului head in registrul 'ebx'
- in registrul 'edi' calvam valoarea 2 intrucat aceasta este urmatoarea valoare
de cautat
- pentru fiecare valoare din 'edi' mai mica sau egala decat 'n' parcurgem vectorul
de la primul element pana la urlimul folosind registrul 'ecx' ca index
- daca gasim valoarea cautata ii calculam adresa, setam campul 'next' al nodului
precedent la nodul proaspat gasit, reinitializam campul 'edx' cu valoarea nodului
proaspat gasit care devine ultimul nod legat si repetam pasii
- daca una din valorile cautate nu este gasita in vector returnam NULL (0)
- dupa ce am realizat legarea tuturor celor 'n' noduri setam campul 'next' al
nodului 'n' la NULL si incheiem programul print returnarea adresa capului listei


TASK-2 -- OPERATII

- compare_function (functie auxiliara pentru qsort)
    - aceasta functie este folosita pentru a compara doua cuvinte sortandu le
    apoi dupa lungime in prima faza, iar daca aceste cuvinte au aceeasi lungime,
    se sorteaza lexicografic
    - registrul 'esi' - folosit pentru retinerea adresei primului cuvant
    - registrul 'edi' folosit pentru retinerea adresei celui de al doilea cuvant
    - dereferentiem cele doua stringuri pentru a le obtine adresele reale
    - dupa apelul functiei 'strlen' cele doua lungimi ale celor doua cuvinte sunt 
    etinute in registrele 'ebx' (primul) respectiv 'ecx' (al doilea)
    - comparam lungimile : daca ebx < ecx returnem -1, daca ebx > ecx returnam 1,
    iar daca ebx = ecx, facem apel la 'strcmp' pentru a le compara lexicografic
    iar rezultatul returnat de functie este retinut in eax

- sort (functie in care se face apel la qsort)
    - sorteaza vectorul de cuvinte folosind qsort
    - in [ebp + 8] se afla adresa vectorului de cuvinte
    - in [ebp + 12] se afla numarul de cuvinte
    - in [ebp + 16] se afla dimensiunea fiecarui cuvant (4 octeti)
    - punem pe stiva parametrii pentru apelul functiei qsort : poiterul la
    vectorul de cuvinte, numarul de elemente, dimeniunea unui element si poiterul
    la functia de comparare 'compare_function'
    - dupa apel curatam stiva prin eliminarea parametrilor de pe ea

- get_words (extrage cuvintele dintr un sir si le retine intr un vector)
    - se foloseste 'delimiters' care contine delimitatorii sirului cu ajutorul
    carora sunt despartite cuvintele (' ', '.', ',', '\n')
    - registrul 'esi' este folosit pentru a retine sirul
    - registrul 'edi' este folosit pentru a retine vectorul de cuvinte
    - registrul 'ecx' este folosit pentru a retine numarul maxim de cuvinte care
    pot fi salvate in vector 'number_of_words'
    - initializam vectorul 'edi' cu elementel nule pentru siguranta de la ultimul
    la primul element
    - folosim 'strtok' pentru a extrage cuvintele
    - extragem primul cuvant prin primul apel strtok
    - pentru fiecare token returnat de strtok retinut in registrul 'eax' se
    verifica daca este null
    - daca nu este il salvam in vector si continuam pana cand 'ebx' (contor
    pentru elementele deja adaugate in vector) ajunge sa fie egal cu
    'number_of_words'
    - continuam cu apelurile strtok adaugand pe stiva 0 (NULL) in loc de sirul
    initial
- la final returnam vectorul creat si eliberam stiva


TASK-3 -- KFIB

- registrul 'edi' este folosit pentru a retine valoarea lui 'n'
- registrul 'esi' este folosit pentru a retine valoarea lui 'k'
- registrul 'ecx' este folosit drept index in realizarea sumelor recursive
- registrul 'ebx' este folosit pentru a retine valoarea sumelor recursivw
- registrul 'edx' este o copie temporara a lui 'n' pentru a nu ii pierde valoarea
atunci cand calculam 'n-i'
- in 'eax' returnam valoarea functiei
- initial verificam daca 'n < k' : daca este sarim in 'zero_ret' si salvam in
'eax' 0
- daca acest lucru nu a fost indeplinit verificam daca 'n = k' : daca este sarim
in 'one_ret' si salvam in 'eax' 1
- daca niciuna din aceste conditii nu este indeplinita se intra in bucla 'sum_ret' 
cu 'ecx' 1 si 'ebx' 0
- cat timp 'ecx' nu este mai mare decat 'k' salvam 'n' in 'edx' calculan 'n-i' si
apelam recursiv functia 'kfib' dupa ce punem parametrii ei pe stiva
- rezultatul returnat de ea in 'eax' il adaugam la suma retinuta in 'ebx', iar
apoi restauram indexul si trecem la urmatoarea iteratie
- la finalul functiei copiem rezultatul sumai din 'ebx' in 'eax' si il returnam


TASK-4 -- COMPOSITE_PALINDROME

- check_palindrome
    - registrul 'esi' retine sirul care trebuie verificat daca este palindrom
    - registrul 'edi' retine lungimea acestui sir
    - incepem prin a retine valoarea lui 'len / 2' in registrul 'ebx'
    - parcurgem sirul pana 'len / 2' si comparam caracterele aflate pe pozitii
    simetrice : sir[i] cu sir[len -i -1]
    - daca cel putin o pereche nu este egala se returneaza 0 intrucat nu este
    palindrom
    - daca la finalul buclei toate compararile au fost egale se returneaza 1

- composite_palindrome
    - 'current_len' - lungimea totala a sirurilor din masca curenta
    - 'best_len' - lungimea celui mai lung palindrom gasit
    - 'mask' - masca curenta de biti care determina sirurile care vor fi
    concatenate in sirul temporar
    - 'best_str' - pointer catre cel mai bun palindrom gasit
    - 'len' - lungimea sirului obtinut print concatenarea sirurilor din masca
    surenta
    - 'temp_str' - pointer catre sirul care contine concatenarea sirurilor din
    masca
    - registrul 'esi' este pointerul catre vectorul de stringuri
    - registrul 'edi' retine numarul de stringuri din vector
    - genereaza toate seturile de siruri posibile folosind o masca pe biti de la
    1 la 2 ^ n - 1, unde 'n' reprezinta numarul de siruri din vector
    - pentru fiecare masca se calculeaza lungimea totala a sirurilor selectate
    (current_len), iar daca aceasta lungime este nula se trece la urmatoarea
    masca
    - in schimb daca lungimea nu este nula, alocam memorie pentru concatenarea
    tuturor sirurilor marcate in masca, rezultat retinut in 'temp_str' si ii
    retinem lungimea in 'len'
    - verificam daca sirul rezultat este palindrom folosind functia
    'check_palindrome'
    - daca aceasta functie returneaza 0, eliberam memoria si trecem la urmatoarea
    masca
    - daca aceasta returneaza 1, comparam lungimea sirului temporar cu lungimea
    celui mai bun palindrom gasit pana in momentul actual
    - daca lungimea acestuia este mai mare, actualizam 'best_str' cu acest sir
    dupa ce eliberam memoria lui 'best_str' anterior; de asemenea actualizam
    'best_len' cu lungimea palindromului temporar
    - daca lungimile sunt egale, comparam lexicografic folosind strcmp : daca
    acesta returneaza 1 actualizam 'best_str', si de asemenea ii actualizam si
    lungimea, dupa ce eliberam meoria vechiului palindrom
    - la final, dupa ce am epuizat toate mastile, returnal valoarea lui 'best_str' 