! File: dps.f
      program debug_parallel_sum
      implicit none
      include 'omp_lib.h'

      integer, parameter :: n=10

      integer :: i,tid

      integer :: sum

      call OMP_SET_NUM_THREADS(3)

      sum=0.0
!$OMP PARALLEL DO PRIVATE(i) REDUCTION(+:sum)
      do i=1,n
         sum=sum+i
         print *,¡¯i,sum=¡¯,i,sum
      end do
!$OMP END PARALLEL DO
      print *,'sum=',sum

      end program debug_parallel_sum
