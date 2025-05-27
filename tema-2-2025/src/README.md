Antemir Andreea-Catalina 314CA

TASK-1 - NUMBERS

-registrul 'ecx' - folosit drept index pentru parcurgerea array ului din 'esi'
-registrul 'eax' - folosit drept contor al numerelor adaugate in array ul
destinatie 'edi'
-pentru fiecare element din array ul sursa se verifica SUBTASK 1 si SUBTASK 2

SUBTASK 1
-se verifica daca numarul este par sau impar : daca ultimul bit al numarului
este 1 atunci acesta este impar, iar daca este 0, este par
-daca este par se adauga in array ul destinatie
-daca este impar se ignora elementul si se trece la urmatorul

SUBTASK 2
-se verifica daca numarul este putere a lui 2 (n&(n-1)) : daca rezultatul este
0 atunci numarul este putere a lui 2, iar daca este 1, nu este putere a lui 2
-daca numarul este putere a lui 2 se ignora si se trece la urmatorul
-daca nu este putere a lui 2 se adauga in array ul destinatie

-la final, se adauga numarul de elemente adaugate in array ul destinatie retinut
in 'eax'
in 'edx' care este poiterul la lungimea array ului destinatie


TASK-2 - EVENTS

SUBTASK 1
-folosim un loop pentru a parcurge array ul de evenimente care contine 'ecx'
evenimente.
-stocam in 'ax' anul elementului curent (16 biti - word)
-stocam in 'dh' luna elementului curent (8 biti - byte)
-stocam in 'dl' ziua elementului curent (8 biti - byte)
-continuam prin a verifica daca anul este valid : daca se afla in intervalul
[1990, 2030]
-daca anul este valid, verificam luna : daca se afla in intervalul [1, 12]
-daca luna este valida, verificam ziua : daca se afla in intervalul [1, 31]
(pentru lunile ianuarie, martie, mai, iulie, august, octombrie, decembrie),
[1, 30] (pentru lunile aprilie, iunie, septembrie, noiembrie), sau daca este
28 (pentru luna februarie)
-daca se gaseste o varianta in care data este invalida, se seteaza validitatea
la 0 si se trece la urmatorul eveniment.
-daca data este valida, se seteaza validitatea la 1 si se trece la urmatorul
eveniment
-trecerea la urmatorul eveniment se face prin adaugarea la 'ebx' 36 de biti
(dimensiunea intregii structuri event)

SUBTASK 2
-folosim 'ebp' ca index pentru a parcurge array ul de evenimente
-folosim 'edx' ca index pentru interschimabrea elementelor
-'in_loop' : acest label reprezinta mai exact 'for j' de la algoritmul
            de interschimbare
           : salvam lungimea pe stiva pt a refolosi registrul si a nu pierde
            valoarea
           : calculam indecsii elementelor curente (ev[i] si ev[j])
           : comparam validitatile elementelor curente si daca se afla in
            ordine ascendenta facem swap intre evenimente
           : daca validitatile sunt egale, comparam anii si daca se afla in
            ordine descendenta facem swap intre evenimente
           : daca anii sunt si ei egali, comparam lunile si daca se afla in
            ordine descendenta facem swap intre evenimente
           : daca si lunile sunt egale, comparam zilele si daca si ele sunt
            egale facem swap intre evenimente
           : daca si zilele sunt egale, comparam numele prin 'strcmp'
-'strcmp' : folosim 'edi' ca index pentru a parcurge cele 2 siruri de caractere
          : comparam fiecare caracter si daca sunt egale trecem la urmatorul
          : daca nu sunt egale, se verifica care este mai mic si se returneaza
            rezultatul
          : daca ajungem la finalul sirului, se returneaza 0 (sunt egale)
          : in caz contrar, se returneaza 1 (sunt diferite)
-'swap' : folosim 'edi' ca index pentru a parcurge cele 2 structuri de evenimente
         : salvam in stiva structura sursa
         : copiem structura sursa in structura destinatie
         : revenim la structura sursa si copiem structura destinatie
         : revenim la stiva si scoatem structura sursa
-daca avem parte de cazul care nu ne intereseaza la compararea campurilor
structurii, sarim in label ul 'no_swap' care restaureaza lungimea si trece
la urmatorul element din 'for j'
-cand am terminat 'for j', trecem la urmatorul eveniment din 'for i'


TASK-3 - BASE64

-folosim 'ecx' ca index pentru a parcurge sirul de caractere
-folosim 'eax' ca si contor pentru lungimea sirului destinatie
-punem pe stiva valoarea lui 'eax' pentru a putea refolosi registrul
-salvam in 'ebp' toti cei 24 de biti ai sirului sursa concatenati
-salvam pe stiva valoarea lui 'ecx' pentru a putea refolosi registrul
-adaugam in sirul destinatie caracterul reprezentat de primul grup de 6 biti,
urmand sa facem acelasi lucru si pentru urmatoarele 3 grupuri, mutand pozitia
pointer ului sirului destinatie la fiecare pas
-rextauram 'ecx' si 'eax' de pe stiva si le incrementam corespunzator : ecx cu 3
pt urmatorii 3 octeti (24 biti) si eax cu 4, deoarece am adaugat 4 caractere in
sirul destinatie
-la final, in 'end_loop' actualizam lungimeaa sirului destinatie, valoare care
se afla in 'eax'


TASK-4 - SUDOKU

-folosim un vector de frecventa 'visited' pentru a verifica de cate ori apare
fiecare cifra pe linie/coloana/caseta

CHECK_ROW
-initializam intregul vector de frecventa cu 0
-parcurgem fiecare coloana a liniei curente (row * 9 + col) si verificam daca
valoarea ei este in intervalul [1, 9]
-daca este si valoarea ei in vectorul de frecventa este 0 (nevizitata) o marcam
ca vizitata si trecem la urmatoarea coloana
-daca este si valoarea ei in vectorul de frecventa este 1 (vizitata) inseamna
ca linia curenta nu este una valida, deci returnam 2
-daca dupa ce am verificat toate coloanele, vectorul de frecventa contine doar
valori de 1, inseamna ca linia este una valida si returnam 1

CHECK_COLUMN
-initializam intregul vector de frecventa cu 0
-parcurgem fiecare linie a coloanei curente (col * 9 + row) si verificam daca
valoarea ei este in intervalul [1, 9]
-daca este si valoarea ei in vectorul de frecventa este 0 (nevizitata) o marcam
ca vizitata si trecem la urmatoarea linie
-daca este si valoarea ei in vectorul de frecventa este 1 (vizitata) inseamna ca
coloana curenta nu este una valida, deci returnam 2
-daca dupa ce am verificat toate liniile, vectorul de frecventa contine doar
valori de 1, inseamna ca coloana este una valida si returnam 1

CHECK_BOX
-initializam intregul vector de frecventa cu 0
-datorita instructiunii 'div' stim ca box_row = index_caseta / 3 si
box_col = index_caseta % 3
-parcurgem fiecare element al casetei curente (matrice 3x3)
((box_row + index_linie) * 9 + box_col + index_coloana) si verificam daca
valoarea lui este in intervalul [1, 9]
-daca este si valoarea lui in vectorul de frecventa este 0 (nevizitat) il
marcam ca vizitat si trecem la urmatorul element (box[i][j+1])
-daca este si valoarea lui in vectorul de frecventa este 1 (vizitat) inseamna
ca caseta curenta nu este una valida, deci returnam 2
-daca dupa ce am verificat toate elementele casetei, vectorul de frecventa
contine doar valori de 1, inseamna ca caseta este una valida si returnam 1
-'box_pop_and_not_ok' : acest label are rolul de a scoate de pe stiva box_row
salvat initial in 'eax', pe care l am pus pe stiva pentru a putea refolosi
registrul, dupa care sare in 'box_not_ok'