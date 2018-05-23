! File: li.f
      program loop_index
      implicit none
      include 'omp_lib.h'

      integer, parameter :: m=1000
      integer :: i,j,k

      real (kind=8) :: start_time,end_time,used_time
      real (kind=8), dimension(1:m,1:m,1:m) :: x
      real (kind=8) :: sum

      call OMP_SET_NUM_THREADS(8)

      do k=1,m
      do j=1,m
      do i=1,m
         x(i,j,k)=1.0d0
      end do
      end do
      end do

C----------loop index: k j i
      start_time=OMP_GET_WTIME()

      sum=0.0
!$OMP PARALLEL DO PRIVATE(k) SHARED(j,i,x) REDUCTION(+:sum)
      do k=1,m
         do j=1,m
            do i=1,m
               sum=sum+x(i,j,k)
            end do
         end do
      end do
!$OMP END PARALLEL DO
      end_time=OMP_GET_WTIME()
      used_time=end_time-start_time
      print '(a,i20)','k,j,i=',m
      print '(a,d15.7)','sum=',sum
      print '(a,f20.5,a)','k,j,i: used_time=',used_time,'  seconds.'
      print *

C----------loop index: j k i
      start_time=OMP_GET_WTIME()

      sum=0.0
!$OMP PARALLEL DO PRIVATE(k) SHARED(j,i,x) REDUCTION(+:sum)
      do j=1,m
         do k=1,m
            do i=1,m
               sum=sum+x(i,j,k)
            end do
         end do
      end do
!$OMP END PARALLEL DO
      end_time=OMP_GET_WTIME()
      used_time=end_time-start_time
      print '(a,i20)','j,k,i=',m
      print '(a,d15.7)','sum=',sum
      print '(a,f20.5,a)','k,j,i: used_time=',used_time,'  seconds.'
      print *

C----------loop index: i j k
      start_time=OMP_GET_WTIME()

      sum=0.0
!$OMP PARALLEL DO PRIVATE(i) SHARED(j,k,x) REDUCTION(+:sum)
      do i=1,m
         do j=1,m
            do k=1,m
               sum=sum+x(i,j,k)
            end do
         end do
      end do
!$OMP END PARALLEL DO
      end_time=OMP_GET_WTIME()
      used_time=end_time-start_time
      print '(a,i20)','i,j,k=',m
      print '(a,d15.7)','sum=',sum
      print '(a,f20.5,a)','i,j,k: used_time=',used_time,'  seconds.'
      print *

C----------loop index: i k j
      start_time=OMP_GET_WTIME()

      sum=0.0
!$OMP PARALLEL DO PRIVATE(i) SHARED(j,k,x) REDUCTION(+:sum)
      do i=1,m
         do k=1,m
            do j=1,m
               sum=sum+x(i,j,k)
            end do
         end do
      end do
!$OMP END PARALLEL DO
      end_time=OMP_GET_WTIME()
      used_time=end_time-start_time
      print '(a,i20)','i,j,k=',m
      print '(a,d15.7)','sum=',sum
      print '(a,f20.5,a)','i,j,k: used_time=',used_time,'  seconds.'

      end program loop_index
