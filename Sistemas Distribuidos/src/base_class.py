import numpy as np

class SistDistBase:

    def __init__(self, partitions, fileName=None):
        self.dim = 16_000
        self.hdim = self.dim // 2
        self.result = np.array(0.0, 'd')
        if fileName is None:
            self.mat = np.random.rand(self.dim, self.dim)
        else:
            np.loadtxt(f'import/{fileName}')
        self.diagonal = np.array([self.mat[i][i] for i in range(self.dim)])
        self.partitions = partitions

    def work(self, sub_matrix, diagonal_elements):
        diagonal_elements = diagonal_elements.reshape(-1, 1)
        sub_matrix *= diagonal_elements
        return sub_matrix.sum()

    def get_slices(self):
        if self.partitions == 2:
            slices = [
                (0, self.hdim, 0, self.dim),
                (self.hdim, self.dim, 0, self.dim)]
        else:
            slices = [
                (0, self.hdim, 0, self.hdim),
                (self.hdim, self.dim, 0, self.hdim),
                (0, self.hdim, self.hdim, self.dim),
                (self.hdim, self.dim, self.hdim, self.dim)]
        return slices

    def get_sliced_args(self, slice_tuple):
        lin_begin, lin_end, col_begin, col_end = slice_tuple
        mat = self.mat[lin_begin : lin_end, col_begin : col_end]
        diagonal = self.diagonal[lin_begin: lin_end]
        return [mat, diagonal]

    def execute(self):
        pass
