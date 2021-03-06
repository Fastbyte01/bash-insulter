#!/bin/bash
print_message () {
    local messages
    local message

    messages=(
        "Boooo! Fai proprio schifo"
        "Ma non capisci proprio niente?"
        "RTFM!"
        "Haha, pollo!"
        "Wow! Questo è davvero sbagliato!"
        "Patetico"
        "Questo è il peggiore di oggi!"
        "Cambia mestiere, questo non fa per te!"
        "lol"
        "Fai schifo"
        "LoL... per favore smettila"
        "ERRORE_UTENTE_INCOMPETENTE"
        "L'incompetenza è una forma di competenza"
        "Male, molto male"
        "Ma che cavolo combini!"
        "Cos'è questo...?"
        "Dai! C'è la puoi fare... Anzi no"
        "Ci sei andato vicino."
        "Che ne pensi di... scrivere un comando giusto la prossima volta!"
        "Che succede se ti dico che... anche per te c'è speranza di scrivere un comando giusto la prossima volta."
        "Non parli computer???"
        "Questo non è Windows"
        "Lascia stare la riga di comando non fa per te..."
        "E' un ORDINE, allontanati dalla tastiera!"
        "CODICE ERRORE: 1D10T4"
        "Consiglio: scrivi un comando valido!"
        "Lascia stare non fa per te."
        "Questo non è un motore di ricerca."
        "(╯°□°）╯︵ ┻━┻"
        "¯\_(ツ)_/¯"
        "Perchè sei così stupido?!"
        "Penso che i computer non facciano per te..."
        "Perchè mi stai facendo questo?!"
        "Non hai niente di meglio da fare?!"
        "Sto davvero pensando di cancellarmi dal tuo computer..."
        "Questo è il motivo per cui vedi i tuoi figli solo una volta al mese."
        "Vedi, adesso capisci perchè non piaci a nessuno."
        "Stai ancora provando?!"
        "Prova ad usare il cervello la prossima volta!"
        "Per chi mi hai preso per un iPhone!"
        "Ti ho scoperto! Ancora scriviamo comandi a caso, eh?"
        "Sei sempre così stupido o oggi stai dimostrando il tuo meglio?!"
        "Hai sbattuto la testa da bambino? Eh, ammettilo."
        "Il cervello non è tutto. Ma nel tuo caso non è niente."
        "Non lo so cosa è che ti rende così stupido, ma funziona davvero."
        "Non sei così pessimo come dicono le persone, sei davvero peggio.."
        "Due sbagliati non ne fanno uno giusto, pensa per esempio ai tuoi genitori."
        "Se quello che non conosci non ti può fare male, be, tu sei invulnerabile."
        "Tu sei la prova che dio ha un gran senso dell'umorismo."
        "Continua a provare, forse un giorno riuscirai a fare qualcosa di intelligente!"
        "Se le cazzate fossero musica, tu saresti una orchestra."
        "E poi ci sono quei giorni di merda in cui mi capita la gente come te"
        "Aprire il terminale non ti rende per forza di cosa un genio"
        "Premere tasti a caso sulla tastiera funziona solo nei film"
        "E poi ci sono gli utenti evoluti come te, si come no. Credici"
        "Tu sei il tipico di esempio di utonto"
        "Ma davvero ti reputi intelligente?!"
        "Che cos'è che hai scritto?"
        "A volte mi fai davvero paura"
        "Lascia stare la tasteria, prova con carta e penna, se ne sei capace"
        "Vendendo come scrivi, mi sa che usi 123456 come password"
        "Ho controllato sul dizionario e ${USER} è il contrario di intelligente"
        "Per chi mi hai preso, per un sistema Windows"
        "Lascia stare, non fa per te! Torna ad usare Windows XP che è meglio"
        "Bene, dopo questo è meglio che torni a guardare Barbara D'urso in TV"
        "Ah ah ah, si come no"
        "Ma tu hai capito quello che hai scritto?"
        "Non so davvero cosa dire"
        "Chi ti capisce è bravo!"
        "E da quando sei in grado di aprire il terminale?"
        "Lascia stare che non è giornata"
        "Guardare Mr. Robot non ti rende un hacker"
        "Ma sei ceco o stai solo premendo tasti a caso"
        "Io penso... tu... ah, scusa tu non pensi"
    )

   # If CMD_NOT_FOUND_MSGS array is populated use those messages instead of the defaults
    [[ -n ${CMD_NOT_FOUND_MSGS} ]] && messages=( "${CMD_NOT_FOUND_MSGS[@]}" )

    # If CMD_NOT_FOUND_MSGS_APPEND array is populated append those to the existing messages
    [[ -n ${CMD_NOT_FOUND_MSGS_APPEND} ]] && messages+=( "${CMD_NOT_FOUND_MSGS_APPEND[@]}" )

    # Seed RANDOM with an integer of some length
    RANDOM=$(od -vAn -N4 -tu < /dev/urandom)

    # Print a randomly selected message, but only about half the time to annoy the user a
    # little bit less.
    if [[ $((${RANDOM} % 2)) -lt 1 ]]; then
        message=${messages[${RANDOM} % ${#messages[@]}]}
        printf "\n  $(tput bold)$(tput setaf 1)${message}$(tput sgr0)\n\n"
    fi
}

function_exists () {
    # Zsh returns 0 even on non existing functions with -F so use -f
    declare -f $1 > /dev/null
    return $?
}

#
# The idea below is to copy any existing handlers to another function
# name and insert the message in front of the old handler in the
# new handler. By default, neither bash or zsh has has a handler function
# defined, so the default behaviour is replicated.
#
# Also, ensure the handler is only copied once. If we do not ensure this
# the handler would add itself recursively if this file happens to be
# sourced multiple times in the same shell, resulting in a neverending
# stream of messages.
#

#
# Zsh
#
if function_exists command_not_found_handler; then
    if ! function_exists orig_command_not_found_handler; then
        eval "orig_$(declare -f command_not_found_handler)"
    fi
else
    orig_command_not_found_handler () {
        echo "zsh: command not found: $1"
        return 127
    }
fi

command_not_found_handler () {
    print_message
    orig_command_not_found_handler "$@"
}


#
# Bash
#
if function_exists command_not_found_handle; then
    if ! function_exists orig_command_not_found_handle; then
        eval "orig_$(declare -f command_not_found_handle)"
    fi
else
    orig_command_not_found_handle () {
        echo "$0: $1: command not found"
        return 127
    }
fi

command_not_found_handle () {
    print_message
    orig_command_not_found_handle "$@"
}
