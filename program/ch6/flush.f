! File: flush.f
      program flush
      implicit none
      include 'omp_lib.h'

      integer, parameter :: m=1600000
      integer :: tid
      integer, dimension(0:m) :: x

      call OMP_SET_NUM_THREADS(2)

      x=-10
!$OMP PARALLEL PRIVATE(tid) SHARED(x)
      tid=OMP_GET_THREAD_NUM()
      print '(a,3(i5))','initialization: x(i),tid=',x(0),x(m),tid

!$OMP BARRIER
      if(tid == 1)then
        x=1
      end if

      print '(a,3(i5))','before flush: x(i),tid=',x(0),x(m),tid

!$OMP FLUSH(x)
      print '(a,3(i5))','after flush: x(i),tid=',x(0),x(m),tid
!$OMP BARRIER

      print '(a,3(i5))','after barrier: x(i),tid=',x(0),x(m),tid

!$OMP END PARALLEL

      end program flush
