#!/bin/bash

g++ normal.cpp -o normal
g++ threads.cpp -lpthread -o threads
mpic++ -o mpi mpi.cpp
mpic++ -o mix mix.cpp -lpthread

echo "Normal"
for (( i=0; i<5; i++))
	do
		./normal
	done

echo "2 Threads"
for (( i=0; i<5; i++))
	do
		./threads 2
	done

echo "4 Threads"
for (( i=0; i<5; i++))
	do
		./threads 4
	done

echo "2 MPI"
for (( i=0; i<5; i++))
	do
		mpirun -np 3 -machinefile ./maquinas ./mpi
	done

echo "4 MPI"
for (( i=0; i<5; i++))
	do
		mpirun -np 5 -machinefile ./maquinas ./mpi
	done

echo "Mix"
for (( i=0; i<5; i++))
	do
		mpirun -np 3 -machinefile ./maquinas ./mix
	done
