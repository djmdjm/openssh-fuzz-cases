#!/bin/bash

set -x

tmux new -s afl-ssh-keygen -d "nice ~/tmp/afl-0.50b/afl-fuzz -t 500 -i afl -o afl-out -M ssh-keygen-master -f afl-fuzzed-master.key ./ssh-keygen -lf afl-fuzzed-master.key"

nproc=`nproc`
for x in `seq 0 $((nproc - 1))` ; do
	id=`printf "slave%02d" $x`
        echo $id
	tmux new-window -n afl-ssh-keygen -d "nice ~/tmp/afl-0.50b/afl-fuzz -t 500 -i afl -o afl-out -M ssh-keygen-$id -f afl-fuzzed-${id}.key ./ssh-keygen -lf afl-fuzzed-${id}.key"
done
