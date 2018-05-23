! File: snt.f
      program set_num_threads
      implicit none
      include 'omp_lib.h'

      integer :: nthreads_set,nthreads,tid

!$OMP PARALLEL PRIVATE(nthreads,tid)
      nthreads=OMP_GET_NUM_THREADS()
      tid=OMP_GET_THREAD_NUM() 
      print '(a,i3)','number of threads(default)=',nthreads
      print '(a,i3)','id=',tid
!$OMP END PARALLEL

      print '(a)','------before OMP_SET_NUM_THREADS'
      print *

      nthreads_set=3
      call OMP_SET_NUM_THREADS(nthreads_set)
      print '(a,i3)','set_number_threads=',nthreads_set

!$OMP PARALLEL PRIVATE(nthreads,tid)
      nthreads=OMP_GET_NUM_THREADS()
      tid=OMP_GET_THREAD_NUM() 
      print '(a,i3)','number of available threads=',nthreads
      print '(a,i3)','id=',tid
!$OMP END PARALLEL

      end program set_num_threads

