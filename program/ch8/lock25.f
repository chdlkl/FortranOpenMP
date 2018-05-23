! File: lock25.f
      program lock25
      implicit none
      include 'omp_lib.h'

      integer, parameter :: m=5
      integer :: tid,i
      integer (kind=OMP_LOCK_KIND) :: lck

      call OMP_SET_NUM_THREADS(3)

      i=0

      call OMP_INIT_LOCK(lck) 
      call OMP_SET_LOCK(lck) 

!$OMP PARALLEL PRIVATE(tid,i) SHARED(lck)
!$OMP MASTER
      i=i+1
      tid=OMP_GET_THREAD_NUM() 
      call OMP_UNSET_LOCK(lck)
      print '(a,i3,a,i3)','thread id=',tid,'  i=',i
!$OMP END MASTER
!$OMP END PARALLEL

      call OMP_DESTROY_LOCK(lck) 

      end program lock25
