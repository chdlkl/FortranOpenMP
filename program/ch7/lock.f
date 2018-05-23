! File: lock.f
      program lock
      implicit none
      include 'omp_lib.h'

      integer, parameter :: m=5
      integer :: tid,i
      integer (OMP_LOCK_KIND) :: lck

      call OMP_SET_NUM_THREADS(3)

      call OMP_INIT_LOCK(lck) 

!$OMP PARALLEL DO PRIVATE(tid,i) SHARED(lck)
      do i=1,m
         tid=OMP_GET_THREAD_NUM() 
      
         call OMP_SET_LOCK(lck)
         print '(a,i3,a,i3)','thread id=',tid,'  i=',i
         call OMP_UNSET_LOCK(lck)             
      end do
!$OMP END PARALLEL DO

      call OMP_DESTROY_LOCK(lck) 

      end program lock
