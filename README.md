Pianificatori POPF2 e OPTIC in immagine Docker

Sommario
Pianificatori POPF2 e OPTIC in immagine Docker	1
Docker	1
Immagine Docker e i pianificatori	1
Cosa è presente nel Dockerfile?	1
Comandi Docker per l’immagine e per il container	2
Per utilizzare POPF2 e OPTIC	2
Per convertire dalla sintassi MA-PDDL alla sintassi PDDL 2.1	2
Per lanciare l’esecuzione del planner POPF2 per la pianificazione	2
Per lanciare l’esecuzione del planner OPTIC per la pianificazione	3
Sintassi PDDL	3



Docker
Per l’installazione e configurazione di Docker è utile il link ufficiale Docker:
https://www.docker.com/get-started
Può essere installato su Windows, Linux, Mac.

Immagine Docker e i pianificatori
Ho creato una cartella nella quale all’interno vi sono: la cartella del Planner POPF2 (il planner utilizzato negli esempi riportati nel documento “Esempi di funzionamento POPF2”), la cartella del planner OPTIC (che è il successore di POPF2 ma ho riscontrato l’incoveniente che ogni tanto mi bloccava il terminale), la cartella chiamata ma (multi agent) nella quale vi sono più cartelle contenenti scenari multi-agente utilizzabili (se opportunamente convertiti) in input per la pianificazione.
N.B. I planner POPF2 e OPTIC non necessitano di essere compilati, basterà lanciare da terminale gli eseguibili principali con i parametri in input opportuni.
Per gli esempi di piani multi-agente riportati nel documento “Esempi di funzionamento POPF2” è stato utilizzato lo scenario dei taxi (la cartella taxi).
Come accennato prima i domini che troviamo nelle cartelle, se hanno i nomi domain.pddl e problem.pddl, devono essere convertiti poiché vogliamo passare dalla sintassi MA-PDDL alla sintassi PDDL 2.1 poiché i pianificatori temporali non li accettano in input.
La trasformazione in PDDL 2.1 è possibile grazie ad uno script python creato dal tesista Gardini che se n’era occupato nella sua tesi, sempre in collaborazione con il professor Torta.
E infine nella cartella è presente anche il Dockerfile che permetterà di fare la build dell’immagine Docker dal quale poi possiamo istanziare il container Docker, con il quale potremmo utilizzare tutto ciò che abbiamo detto.
Cosa è presente nel Dockerfile?
Dockerfile:
FROM ubuntu:18.04
COPY .   /app
RUN apt-get update –y
RUN apt-get install build-essential –y
RUN apt-get install cmake coinor-libcbc-dev coinor-libclp-dev coinor-libcoinutils-dev coinor-libosi-dev coinor-libcgl-dev doxygen bison flex –y
RUN apt-get install python -y
Come immagine di base utilizza l’immagine di ubuntu 18.04, copia nella cartella app tutte le cartelle dette in precedenza, pertanto bisognerà spostarsi in quella cartella per trovare tutto, poi andrà ad eseguire dei comandi a terminale per effettuare le installazioni necessarie al funzionamento dei planner (in particolare l’ultima).



Comandi Docker per l’immagine e per il container

1. Per fare la build dell’immagine utilizziamo:
docker build --tag dockerplanners:1.0 –f "./Dockerfile" .
dockerplanners:1.0 è il tag che diamo all’immagine (si può scegliere anche un altro nome volendo).
Poi indichiamo il percorso del Dockerfile per fare la build.
N.B. Dato che nel Dockerfile abbiamo indicato con il . il voler prendere il contenuto della cartella corrente, per copiarlo in /app, è meglio che lanciamo il comando dentro la cartella DockerPlanners.

Da notare il punto alla fine che non è da dimenticare.
2. Per istanziare un container dall’immagine:

docker run -d -it dockerplanners:1.0
3. Andiamo a cercare il container id del container appena istanziato:
docker ps -a
Esempio di container id : 3930385e995e
4. Per aprire la bash del container:
docker start -ai container_id
Per semplicità si può anche soltanto scrivere 3930.

Ci ritroveremo di fronte alla bash e andando nella cartella app troveremo pianificatori ecc.
Nel caso si volesse uscire dalla bash basta scrivere exit e fare invio.

Per utilizzare POPF2 e OPTIC

Per convertire dalla sintassi MA-PDDL alla sintassi PDDL 2.1
Nel caso si abbia la necessità di convertire domini (domain.pddl) e problemi (problem.pddl) da MA-PDDL a PDDL 2.1:
python matopddl.py /app/scenariosPlanner/ma/taxi/p01 domain problem
Indichiamo la cartella dove prendere i file PDDL domain e problem e nella stessa cartella verranno creati i file in sintassi PDDL, domainS.pddl e problemS.pddl, da utilizzare poi in input per i pianificatori.

Per lanciare l’esecuzione del planner POPF2 per la pianificazione

cd /app/popf2Planner
./planPopf2 /app/scenariosPlanner/ma/taxi/p23/domainS.pddl /app/scenariosPlanner/ma/taxi/p23/problemS.pddl outputp23

./plan dominio   problema   nome_file_output

Per lanciare l’esecuzione del planner OPTIC per la pianificazione

cd /app/opticPlanner/release/optic
./planOptic /app/scenariosPlanner/ma/taxi/p23/domainS.pddl /app/scenariosPlanner/ma/taxi/p23/problemS.pddl outputp23

Nel caso si volesse provare a lanciare POPF2 oppure OPTIC con altre opzioni, esse si possono srivendo nel terminale:
Per POPF2 --> /app/popf2Planner/compile/popf2/popf3-clp
Per OPTIC  --> /app/opticPlanner/release/optic/optic-clp
E scelte le opzioni alle quale si è interessati le si possono inserire nei rispettivi eseguibili plan (POPF2) e planOptic (OPTIC), aprendoli con un comune editor di testo.

Sintassi PDDL 2.1
(https://planning.wiki/ref/pddl21)
Per dare una breve spiegazione della sintassi PDDL guardiamo prima un file domainS.pddl e poi un file problemS.pddl.
domainS.pddl:
(:requirements :strips :typing :fluents :durative-actions) 
* Possiamo vederle un po’ come le import/include dei linguaggi di programmazione, quando dichiariamo di avere la necessità di importare quelle librerie.
:types
* Permette di definire i tipi del dominio sui quali applicheremo i predicati.
o agent e location li definiamo come object
o taxi e passeggeri come agent

:predicates
* Definiamo i predicati, i quali si può specificare su quali tipi di oggetti si applicano o se a tutti gli oggetti.
* Predicati sono true o false.

:functions
* Possiamo usare delle functions per avere dei valori numerici, avendo così a disposizione qualcosa di differente dai semplici true e false dei predicati.
o Es. possiamo usarle per tenere traccia di quanto tempo ha viaggiato un taxi
o Esse possono essere aumentate o diminuite con le increase negli effetti delle azioni.

:durative-action
* :parameters
o Specifichiamo i parametri in input di quell’azione
* :duration 
o Specifichiamo la durata dell’azione 
* :condition
o Specifichiamo le precondizioni che devono essere tutte a true, tutte verificate, per poter eseguire quell’azione.
* Notare gli at start e at end. Per indicare quando quel predicato deve essere true, se all’inizio o alla fine dell’azione.
* :effect
o Specifichiamo gli effetti che porterà quell’azione.
* Notare gli at start e at end. Per indicare quando quel predicato sarà true, se all’inizio o alla fine dell’azione.

problemS.pddl:
:objects
* Dichiariamo tutti gli oggetti che fanno parte del problema.

:init
* Inizializziamo i predicati
* Se utilizzate, inizializziamo anche i valori delle functions

:goal
* È lo stato finale che si deve raggiungere, il planner schedulerà le azioni con l’obiettivo di arrivare a questo stato finale nel minor tempo possibile (se si vuole minimizzare il makespan, che è di default se non si specifica niente in :metric )
* Lo stato finale è in AND e pertanto devono essere true tutte le preposizioni indicate.
o Oltre alle preposizioni si possono usare anche delle condizioni sulle functions che anche esse daranno true o false.
* Es tempo impiegato dal taxi t1 è > 20?
* (> (time-travelled t1) 20)

:metric
* Utilizzando metric è possibile dichiarare di essere interessati a minimizzare o massimizzare qualche quantità.
o Es. (:metric maximize (time-travelled t1))
* Si appoggia alle functions
* Se metric non è indicato, per default il planner punterà a minimizzare il makespan (minimizzare il tempo impiegato per giungere allo stato finale/:goal).
 













