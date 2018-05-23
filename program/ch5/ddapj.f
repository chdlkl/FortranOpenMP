! File: ddapj.f
      program double_do_array_plus_j
      implicit none
      include 'omp_lib.h'

      integer, parameter :: m=3,n=3
      integer :: nthreads,tid,i,j
      integer, dimension(1:m,1:n) :: a,b,c

      call OMP_SET_NUM_THREADS(3)

         print '(a)','nthreads    tid       i       j    c(i,j)'

!$OMP PARALLEL DO PRIVATE(i,j,tid,nthreads) DEFAULT(SHARED)
      do j=1,n
      do i=1,m
         a(i,j)=i+j
         b(i,j)=(i+j)*10
         c(i,j)=a(i,j)+b(i,j)
         tid=OMP_GET_THREAD_NUM() 
         nthreads=OMP_GET_NUM_THREADS()
         print '(i5,7(i8))',nthreads,tid,i,j,c(i,j)
      end do
      print '(a)','---------------'
      end do
!$OMP END PARALLEL DO

      end program double_do_array_plus_j

