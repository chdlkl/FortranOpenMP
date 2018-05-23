! File: tt.f
      program timetick
      implicit none
      include 'omp_lib.h'

      integer, parameter :: m=1000000
      integer :: i,j

      real (kind=8) :: start_time,end_time,used_time
      real (kind=8) :: tick
      real (kind=8) :: x

      call OMP_SET_NUM_THREADS(2)

      start_time=OMP_GET_WTIME()
      print '(a,f20.5,a)','start_time=',start_time,'  seconds.'

      do i=1,m
!$OMP PARALLEL DO PRIVATE(j,x) 
         do j=1,m
            x=log(exp(sin(1.1**1.1)**1.1+1.0)+1.0)
         end do
!$OMP END PARALLEL DO
      end do

      end_time=OMP_GET_WTIME()
      print '(a,f20.5,a)','end_time=',end_time,'  seconds.'

      used_time=end_time-start_time
      print '(a,f20.5,a)','used_time=',used_time,'  seconds.'

      tick=OMP_GET_WTICK()
      print '(a,d13.5,a)','tick=',tick,'  seconds.'

      end program timetick
