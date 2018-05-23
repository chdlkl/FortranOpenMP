! File: ip.f
      program if_parallel
      implicit none
      include 'omp_lib.h'
      integer :: nthreads,tid,ncpu

      ncpu=OMP_GET_NUM_PROCS()
      print '(a,i3)','number of CPUs:',ncpu
      print *

!$OMP PARALLEL PRIVATE(nthreads,tid) IF (ncpu > 1)
      nthreads=OMP_GET_NUM_THREADS()
      tid=OMP_GET_THREAD_NUM()
      print '(a,i3,a,i3)','number of threads:',nthreads,' id=',tid
!$OMP END PARALLEL

      end program if_parallel
