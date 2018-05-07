import threading
import numpy as np
from mpi4py import MPI
from .mpi_version import MPIVersion


class MixVersion(MPIVersion):

    def __init__(self, fileName=None):
        super(MixVersion, self).__init__(2, fileName)
        if self.rank is not 0:
            self._threads = []
            self.results = []

    def execute(self):
        if self.rank == 0:
            self.comm.Reduce(
                [np.array(0.0, 'd'), MPI.DOUBLE],
                [self.result, MPI.DOUBLE],
                op=MPI.SUM,
                root=0)
        else:
            for index in range(2):
                self._threads.append(threading.Thread(
                    target=self.work_and_save,
                    name=f'worker-{self.rank}-{index}',
                    args=[
                        self.mat[:, self.hdim * index : self.hdim * (index + 1)],
                        self.diagonal]))
                self._threads[-1].start()
            for thread in self._threads:
                thread.join()
            self.result += np.array(self.results).sum()
            self.comm.Reduce(
                [self.result, MPI.DOUBLE],
                None,
                op=MPI.SUM,
                root=0)

    def work_and_save(self, sub_matrix, diagonal_elements):
        self.results.append(self.work(sub_matrix, diagonal_elements))
