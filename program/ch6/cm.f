! File: cm.f
      program critical_max
      implicit none
      include 'omp_lib.h'

      integer, parameter :: m=10
      integer, dimension(1:m) :: p
      integer :: tid,nthreads
      integer :: i,pmax,px

      CALL OMP_SET_NUM_THREADS(3)

      do i=1,m
         p(i)=i
      end do

      px=0
!$OMP PARALLEL PRIVATE(pmax,i,tid,nthreads) SHARED(p,px)
      pmax=0

!$OMP DO
      do i=1,m
         pmax=max(pmax,p(i))
      end do
!$OMP END DO NOWAIT

!$OMP CRITICAL
      tid=OMP_GET_THREAD_NUM() 
      nthreads=OMP_GET_NUM_THREADS()
      print '(a,i5,i5)','number of threads, id=',nthreads,tid
      print '(a,i5,i5)','pmax,px=',pmax,px
      px=max(px,pmax)
!$OMP END CRITICAL

!$OMP END PARALLEL

      print '(a,i5)','max(p(i))=',px

      end program critical_max
