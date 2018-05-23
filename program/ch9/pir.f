! File: pir.f
      program pi_reduction
      implicit none
      include 'omp_lib.h'

      integer (kind=4), parameter :: num_steps=1000000000
      integer, parameter :: nthreads=4

      integer :: i

      real (kind=8) :: x,pi,step,sum
      real (kind=8) :: start_time,end_time,used_time

      start_time=OMP_GET_WTIME()

      call OMP_SET_NUM_THREADS(nthreads)

      step=1.0/dble(num_steps)
      sum=0.0

!$OMP PARALLEL PRIVATE(x,i) DEFAULT(SHARED)
!$OMP DO REDUCTION(+:sum)
      do i=0,num_steps-1
         x=(dble(i)+0.5)*step
         sum=sum+4.0/(1.0+x*x)
      end do
!$OMP END DO
!$OMP END PARALLEL

      pi=step*sum

      end_time=OMP_GET_WTIME()

      used_time=end_time-start_time
      print '(a,f13.7,a)','used_time=',used_time,'  seconds'

      print '(a,f20.15,a)','pi=',pi,' --calculated'
      print '(a)','pi=   3.141592653589793 --correct'

      end program pi_reduction
