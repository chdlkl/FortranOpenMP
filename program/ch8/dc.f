! File: dc.f
      program do_collapse
      implicit none
      include 'omp_lib.h'

      integer, parameter :: l=4,m=4,n=2
      integer :: tid,i,j,k

      call OMP_SET_NUM_THREADS(3)

!$OMP PARALLEL DO COLLAPSE(2) PRIVATE(i,j,k,tid) DEFAULT(SHARED)
      do i=1,l
         do j=1,m
            do k=1,n
               tid=OMP_GET_THREAD_NUM()
               print '(a,4(2x,i4))','tid,i,j,k=',tid,i,j,k
            end do
         end do
      end do
!$OMP END PARALLEL DO

      end program do_collapse
