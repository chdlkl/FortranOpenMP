! File: ps.f
      program private_shared
      implicit none
      include 'omp_lib.h'

      integer :: tid

      integer :: a,b,c

      call OMP_SET_NUM_THREADS(3)

      a=-1
      b=-2
      c=-3

      tid=OMP_GET_THREAD_NUM() 

      print '(a,3(i4),a,i4)','a,b,c=',a,b,c,'  id=',tid
      print '(a)','-----before parallel'
      print *

!$OMP PARALLEL DEFAULT(PRIVATE) SHARED(c)
      tid=OMP_GET_THREAD_NUM() 

      print '(a,3(i4),a,i4)','a,b,c=',a,b,c,'  id=',tid

      b=10+tid
      c=10+tid

      print '(a,3(i4),a)','a,b,c=',a,b,c,'  b&c changed'

      print *
!$OMP END PARALLEL 

      tid=OMP_GET_THREAD_NUM() 

      print '(a)','-----after parallel'

      print '(a,3(i4),a,i4)','a,b,c=',a,b,c,'  id=',tid

      end program private_shared



