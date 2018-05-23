! File: critical.f
      program critical
      implicit none
      include 'omp_lib.h'

      integer, parameter :: m=5
      integer :: tid,i

      call OMP_SET_NUM_THREADS(3)


!$OMP PARALLEL DO PRIVATE(tid,i) 
      do i=1,m
         tid=OMP_GET_THREAD_NUM() 
      
!$OMP CRITICAL
         print '(a,i3,a,i3)','thread id=',tid,'  i=',i
!$OMP END CRITICAL

      end do
!$OMP END PARALLEL DO

      end program critical
