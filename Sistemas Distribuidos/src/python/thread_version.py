import threading
import numpy as np
from base_class import SistDistBase


class ThreadVersion(SistDistBase):

    def __init__(self, thread_count, fileName=None):
        super(ThreadVersion, self).__init__(thread_count, fileName)
        self._threads = []
        self.results = []

        for index, slice_tuple in enumerate(self.get_slices()):
            self._threads.append(threading.Thread(
                target=self.work_and_save,
                name=f'worker-{index}',
                args=self.get_sliced_args(slice_tuple)))

    def work_and_save(self, sub_matrix, diagonal_elements):
        self.results.append(self.work(sub_matrix, diagonal_elements))

    def execute(self):
        for thread in self._threads:
            thread.start()
        for thread in self._threads:
            thread.join()
        self.result = np.array(self.results).sum()
