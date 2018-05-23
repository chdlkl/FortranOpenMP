! File: ipp.f
      program if_parallel_print
      implicit none
      include 'omp_lib.h'

      call printnumthreads(2)
      print *

      call printnumthreads(20)

      end program if_parallel_print

C----------------------------------------------------------
      subroutine printnumthreads(n)
      implicit none
      include 'omp_lib.h'
      integer :: n,nthreads

!$OMP PARALLEL PRIVATE(nthreads) IF(n>10) NUM_THREADS(4)
      nthreads=OMP_GET_NUM_THREADS()
      print '(a,i3,i5)','number of threads,n=',nthreads,n
!$OMP END PARALLEL

      return
      end subroutine printnumthreads
