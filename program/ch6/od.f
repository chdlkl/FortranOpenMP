! File: od.f
      program ordered_do
      implicit none
      include 'omp_lib.h'

      integer, parameter :: m=10
      integer, dimension(1:m) :: a
      integer :: tid,nthreads
      integer :: i

      CALL OMP_SET_NUM_THREADS(3)

      print '(a)','nthreads   id    i   a(i)'

!$OMP PARALLEL PRIVATE(i,tid,nthreads) SHARED(a)

!$OMP DO
      do i=1,m
         tid=omp_get_thread_num() 
         nthreads=omp_get_num_threads()
         a(i)=i
         print '(4(i6))',nthreads,tid,i,a(i)
      end do
!$OMP END DO

         print *

!$OMP DO ORDERED
      do i=2,m
!$OMP ORDERED
         tid=omp_get_thread_num() 
         nthreads=omp_get_num_threads()
         a(i)=a(i-1)-1
         print '(4(i6))',nthreads,tid,i,a(i)
!$OMP END ORDERED
      end do
!$OMP END DO

!$OMP END PARALLEL

      end program ordered_do

