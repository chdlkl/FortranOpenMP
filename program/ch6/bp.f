! File: bp.f
      program barrier_parallel
      implicit none
      include 'omp_lib.h'

      integer :: tid,nthreads

      CALL OMP_SET_NUM_THREADS(3)

!$OMP PARALLEL PRIVATE(tid,nthreads)
      tid=OMP_GET_THREAD_NUM() 
      print '(a,i5)','hello from thread id=',tid
!$OMP BARRIER
      if (tid == 0) then
        nthreads=omp_get_num_threads()
        print '(a,i5,a)','there are',nthreads,' threads to say hello!'
      end if
!$OMP END PARALLEL

      end program barrier_parallel
