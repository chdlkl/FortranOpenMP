! File: fl.f
      program firstprivate_lastprivated
      implicit none
      include 'omp_lib.h'

      integer, parameter :: m=4
      integer :: tid,i,j

      integer,dimension(1:m) :: a,b

      call OMP_SET_NUM_THREADS(3)

      a=-10
      b=-10

      tid=OMP_GET_THREAD_NUM() 

      print '(a,4(i4),a,i3)','a=',(a(j),j=1,m),' id=',tid
      print '(a,4(i4))','b=',(b(j),j=1,m)
      print '(a)','-----before parallel'
      print *

!$OMP PARALLEL DO PRIVATE(tid,i,j) FIRSTPRIVATE(a,b) LASTPRIVATE(b)
      do i=1,m
         tid=OMP_GET_THREAD_NUM() 
         print '(a,4(i4),a,i3)','a=',(a(j),j=1,m),' id=',tid
         print '(a,4(i4))','b=',(b(j),j=1,m)

         a(i)=tid+i*10
         b(i)=tid+i*10

         print '(a,4(i4),a,i3)','a=',(a(j),j=1,m),' id=',tid
         print '(a,4(i4),a,i4)','b=',(b(j),j=1,m),' changed i=',i
         print *
      end do
!$OMP END PARALLEL DO

      tid=OMP_GET_THREAD_NUM() 

      print '(a)','-----after parallel'
      print '(a,4(i4),a,i3)','a=',(a(j),j=1,m),' id=',tid
      print '(a,4(i4))','b=',(b(j),j=1,m)

      end program firstprivate_lastprivated
