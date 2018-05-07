import sys
from src.mpi_version import MPIVersion
from src.mix_version import MixVersion
from src.thread_version import ThreadVersion

fileName = None

#test.py type (qtd) (fileName)

if sys.argv[1] == "Thread":
    if len(sys.argv) == 4:
        fileName = sys.argv[3]
    tv = ThreadVersion(int(sys.argv[2]), fileName)
    tv.execute()
    print(tv.result)
else:
    if sys.argv[1] == "MPI":
        if len(sys.argv) == 4:
            fileName = sys.argv[3]
        mv = MPIVersion(int(sys.argv[2]), fileName)
    elif sys.argv[1] == "Mix":
        if len(sys.argv) == 3:
            fileName = sys.argv[2]
        mv = MixVersion(fileName)
    mv.send_receive()
    mv.execute()
    if mv.rank == 0:
        print(mv.result)
