! File: mp.f
      program master_parallel
      implicit none
      include 'omp_lib.h'

      integer :: tid,nthreads

      CALL OMP_SET_NUM_THREADS(3)

!$OMP PARALLEL PRIVATE(tid,nthreads)

         tid=OMP_GET_THREAD_NUM() 
         nthreads=OMP_GET_NUM_THREADS()
         print '(a,i5,i5)','before master: nthreads,id=',nthreads,tid

!$OMP MASTER
         tid=OMP_GET_THREAD_NUM() 
         nthreads=OMP_GET_NUM_THREADS()
         print '(a,i5,i5)','master region: nthreads,id=',nthreads,tid
!$OMP END MASTER

         tid=OMP_GET_THREAD_NUM() 
         nthreads=OMP_GET_NUM_THREADS()
         print '(a,i5,i5)','after master: nthreads,id=',nthreads,tid

!$OMP END PARALLEL

      end program master_parallel

