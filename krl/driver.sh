#!/bin/bash

set -x

tmux new -s afl-ssh-keygen -d "~/afl-0.61b/afl-fuzz -t 500 -i afl-in -o afl-out -M ssh-keygen-master -f afl-fuzzed-master.krl ./ssh-keygen -Qf afl-fuzzed-master.krl ~/openssh/afl-misc/key.pub"

nproc=`nproc`
for x in `seq 0 $((nproc - 1))` ; do
	id=`printf "slave%02d" $x`
        echo $id
	tmux new-window -n afl-ssh-keygen -d "~/afl-0.61b/afl-fuzz -t 500 -i afl-in -o afl-out -M ssh-keygen-$id -f afl-fuzzed-${id}.krl ./ssh-keygen -Qf afl-fuzzed-${id}.krl ~/openssh/afl-misc/key.pub"
done
