# Ti insulto

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/99fe9378af2e4194ab098e2c154b2ae7)](https://app.codacy.com/app/rogepix/ti-insulto?utm_source=github.com&utm_medium=referral&utm_content=Fastbyte01/ti-insulto&utm_campaign=Badge_Grade_Dashboard)

Insulta l'utente quando scrive comandi sbagliati.

Cambia gli insulti come preferisci :)

```bash
fastbyte01@fastbyte:~ $ sl

  Lascia stare non fa per te

-bash: sl: command not found
fastbyte01@fastbyte:~ $ gti status

  Non hai niente di meglio da fare?!

-bash: gti: command not found
fastbyte01@fastbyte:~ $ sp aux

  A volte mi fai davvero paura

-bash: sp: command not found
```

# Compatibilità
* Bash v4 e successivo
* Zsh

# Installazione

    # Metodo 1 - Sai quello che stai facendo
    git clone https://github.com/Fastbyte01/ti-insulto.git ti-insulto
    sudo cp ti-insulto/src/bash.command-not-found /etc/


Per utilizzare lo script al login bisogna aggiungere il seguente codice nel file  `/etc/bash.bashrc` o in una posizione differente dove puoi configurare automaticamente la tua shell durante il login (zsh ha dei file di configurazione diversi):
```
if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi
```
Esegui il logout e poi di nuovo il login. A questo punto, quando digiti dei comandi sbagliati l'effetto sarà visibile.

# Configurazione
Ti insulto può essere personalizzato inserendo delle nuove frasi nelle variabili d'ambientec `CMD_NOT_FOUND_MSGS` o `CMD_NOT_FOUND_MSGS_APPEND`. I valori devono essere degli array. `CMD_NOT_FOUND_MSGS` rimpiazza i messaggi di default, mentre `CMD_NOT_FOUND_MSGS_APPEND` aggiunge altri messaggi a quelli esistenti.
