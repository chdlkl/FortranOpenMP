! File: p.f
      program parallel
      implicit none
      include 'omp_lib.h'

      integer :: nthreads,tid

      nthreads=OMP_GET_NUM_THREADS()
      tid=OMP_GET_THREAD_NUM() 
      if(OMP_IN_PARALLEL())then
         print '(a,i3)','in the parallel region! id=',tid
         print '(a,i3)','number of threads:',nthreads
      else
         print '(a,i3)','in the serial region! id=',tid
         print '(a,i3)','number of threads:',nthreads
      end if

      print '(a)','-----before parallel region'
      print *

!$OMP PARALLEL PRIVATE(nthreads,tid)
      nthreads=OMP_GET_NUM_THREADS()
      tid=OMP_GET_THREAD_NUM() 
      if(OMP_IN_PARALLEL())then
         print '(a,i3)','in the parallel region! id=',tid
         print '(a,i3)','number of threads:',nthreads
      else
         print '(a,i3)','in the serial region! id=',tid
         print '(a,i3)','number of threads:',nthreads
      end if
!$OMP END PARALLEL
      print *

      print '(a)','-----after parallel region'

      nthreads=OMP_GET_NUM_THREADS()
      tid=OMP_GET_THREAD_NUM() 
      if(OMP_IN_PARALLEL())then
         print '(a,i3)','in the parallel region! id=',tid
         print '(a,i3)','number of threads:',nthreads
      else
         print '(a,i3)','in the serial region! id=',tid
         print '(a,i3)','number of threads:',nthreads
      end if

      end program parallel
