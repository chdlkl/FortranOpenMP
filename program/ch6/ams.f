! File: ams.f
      program atomic_max_sum
      implicit none
      include 'omp_lib.h'

      integer, parameter :: m=10
      integer :: i,xymax,sum
      integer, dimension(1:m) :: x,y

      call omp_set_num_threads(3)

      xymax=-10
      sum=0

!$OMP PARALLEL PRIVATE(i) SHARED(x,y,xymax,sum)
!$OMP DO
      do i=1,m
         x(i)=i
         y(i)=10*i
      end do
!$OMP END DO

!$OMP DO
      do i=1,m
!$OMP ATOMIC
         sum=sum+x(i)+y(i)
!$OMP ATOMIC
         xymax=max(xymax,x(i),y(i))
      print '(a,3(i5))','i,x(i),y(i)=',i,x(i),y(i)
      end do
!$OMP END DO

!$OMP END PARALLEL

      print *
      print '(a,3(i5))','xymax,sum=',xymax,sum

      end program atomic_max_sum
