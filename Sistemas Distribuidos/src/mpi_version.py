import numpy as np
from mpi4py import MPI
from .base_class import SistDistBase

class MPIVersion(SistDistBase):

    def __init__(self, partitions, fileName=None):
        self.comm = MPI.COMM_WORLD
        self.rank = self.comm.Get_rank()
        self.result = np.array(0.0, 'd')
        if self.rank == 0:
            super(MPIVersion, self).__init__(partitions, fileName)
        else:
            self.partitions = partitions
            self.dim = 16_000
            self.hdim = self.dim // 2
            self.mat = np.empty(self.hdim * 2 * self.dim // partitions, dtype=np.float64)
            self.diagonal = np.empty(self.hdim, dtype=np.float64)

    def send_receive(self):
        if self.rank == 0:
            for index, slice_tuple in enumerate(self.get_slices()):
                data = self.get_sliced_args(slice_tuple)
                dest = index + 1
                self.comm.Send(data[0].reshape(-1), dest=dest, tag=0)
                self.comm.Send(data[1], dest=dest, tag=1)
        else:
            self.comm.Recv(self.mat, source=0, tag=0)
            self.mat = self.mat.reshape(self.hdim, -1)
            self.comm.Recv(self.diagonal, source=0, tag=1)

    def execute(self):
        if self.rank == 0:
            self.comm.Reduce(
                [np.array(0.0, 'd'), MPI.DOUBLE],
                [self.result, MPI.DOUBLE],
                op=MPI.SUM,
                root=0)
        else:
            self.result += self.work(self.mat, self.diagonal)
            self.comm.Reduce(
                [self.result, MPI.DOUBLE],
                None,
                op=MPI.SUM,
                root=0)
