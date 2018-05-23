! File: vtc.f
      program variable_type_common
      implicit none
      include 'omp_lib.h'

      integer, parameter :: m=5
      integer tid,nthreads,i

      integer, dimension(1:m) :: a,b,c
      common /input/ a,c

      call OMP_SET_NUM_THREADS(2)

      do i=1,m
         a(i)=i
         b(i)=10*i  
         c(i)=100*i
      end do

      print '(a,5(1x,i4))','a(i)=',(a(i),i=1,m)
      print '(a,5(1x,i4))','b(i)=',(b(i),i=1,m)
      print '(a,5(1x,i4))','c(i)=',(c(i),i=1,m)

      tid=OMP_GET_THREAD_NUM() 
      nthreads=OMP_GET_NUM_THREADS()

      print '(a,i4,i4)','--before parallel: nthreads,tid=',nthreads,tid

!$OMP PARALLEL DEFAULT(SHARED) PRIVATE(tid,nthreads,i)
      tid=OMP_GET_THREAD_NUM() 
      nthreads=OMP_GET_NUM_THREADS()

      print *
      print '(a,i4,i4)','--during parallel: nthreads,tid=',nthreads,tid

!$OMP DO
      do i=1,m
         call work(b,i,tid)
      end do
!$OMP END DO

!$OMP END PARALLEL 

      print *
      print '(a,i4,i4)','--after parallel: nthreads,tid=',nthreads,tid
      print '(a,5(1x,i4))','a(i)=',(a(i),i=1,m)
      print '(a,5(1x,i4))','b(i)=',(b(i),i=1,m)
      print '(a,5(1x,i4))','c(i)=',(c(i),i=1,m)

      end program variable_type_common

C----------------------------------------------------------
      subroutine work(b,index,tid)
      implicit none
      integer, parameter :: m=5
      integer, dimension(1:m) :: a,b,c
      common /input/ a,c

      integer tid,nthreads,i
      integer :: temp,index

      temp=tid

      c(index)=a(index)+b(index)

      print '(a,i4,i4)','subroutine work: index, tid=',index,tid
      print '(a,5(1x,i4))','c(i)=',(c(i),i=1,m)

      return
      end subroutine work
