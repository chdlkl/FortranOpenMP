! File: sd.f
      program set_dynamic
      implicit none
      include 'omp_lib.h'

      integer :: nthreads_set,nthreads,tid

      nthreads_set=3
      call OMP_SET_DYNAMIC(.TRUE.)
      call OMP_SET_NUM_THREADS(nthreads_set)
      print '(a,i3)','set_number_threads=',nthreads_set

      print *,'dynamic region(true or false):',OMP_GET_DYNAMIC()

!$OMP PARALLEL PRIVATE(nthreads,tid)
      nthreads=OMP_GET_NUM_THREADS()
      tid=OMP_GET_THREAD_NUM() 

      print '(a,i3)','number of threads=',nthreads
      print '(a,i3)','tid=',tid
      print *,'--------------------'
!$OMP END PARALLEL

      end program set_dynamic

