! File: rd.f
      program reduction_do
      implicit none
      include 'omp_lib.h'

      integer, parameter :: m=5
      integer :: tid,i

      integer, dimension(1:m) :: a(m),b(m)
      integer :: sum,pdt,abmax

      call OMP_SET_NUM_THREADS(3)

      do i=1,m
         a(i)=i
         b(i)=100*i
      end do
      print '(a,5(1x,i4))','a(i)=',(a(i),i=1,m)
      print '(a,5(1x,i4))','b(i)=',(b(i),i=1,m)
      print *

      sum=0
!$OMP PARALLEL DO PRIVATE(i,tid) SHARED(a,b) REDUCTION(+:sum)
      do i=1,m
         tid=OMP_GET_THREAD_NUM() 
         sum=sum+a(i)+b(i)
         print '(a,i4,i4,a,i4)','i,sum=',i,sum,'  id=',tid
      end do
!$OMP END PARALLEL DO
      print '(a,i4)','sum=',sum
      print *

      pdt=1        
!$OMP PARALLEL DO PRIVATE(i,tid) SHARED(a) REDUCTION(*:pdt)
      do i=1,m
         tid=OMP_GET_THREAD_NUM() 
         pdt=pdt*a(i)
         print '(a,i4,i4,a,i4)','i,pdt=',i,pdt,'  id=',tid
      end do
!$OMP END PARALLEL DO
      print '(a,i4)','pdt=',pdt
      print *

      abmax=-10000       
!$OMP PARALLEL DO PRIVATE(i,tid) SHARED(a,b) REDUCTION(max:abmax)
      do i=1,m
         tid=OMP_GET_THREAD_NUM() 
         abmax=max(abmax,a(i),b(i))
         print '(a,i4,i4,a,i4)','i,abmax=',i,abmax,'  id=',tid
      end do
!$OMP END PARALLEL DO
      print '(a,i4)','abmax=',abmax

      end program reduction_do

