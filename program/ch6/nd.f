! File: nd.f
      program nowait_do
      implicit none
      include 'omp_lib.h'

      integer, parameter :: m=4
      integer :: tid,nthreads,i

      CALL OMP_SET_NUM_THREADS(3)

!$OMP PARALLEL PRIVATE(tid,nthreads,i)

!$OMP DO
      do i=1,m
         tid=OMP_GET_THREAD_NUM() 
         nthreads=OMP_GET_NUM_THREADS()
         print '(a,i5,i5)','first do_loop: nthreads,id=',nthreads,tid
      end do
!$OMP END DO

!$OMP DO
      do i=1,m
         tid=OMP_GET_THREAD_NUM() 
         nthreads=OMP_GET_NUM_THREADS()
         print '(a,i5,i5)','second do_loop: nthreads,id=',nthreads,tid
      end do
!$OMP END DO NOWAIT

!$OMP DO
      do i=1,m
         tid=OMP_GET_THREAD_NUM() 
         nthreads=OMP_GET_NUM_THREADS()
         print '(a,i5,i5)','third do_loop: nthreads,id=',nthreads,tid
      end do
!$OMP END DO

!$OMP END PARALLEL

      end program nowait_do
