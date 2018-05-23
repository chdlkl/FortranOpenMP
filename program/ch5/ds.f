! File: ds.f
      program do_schdule
      implicit none
      include 'omp_lib.h'

      integer, parameter :: m=10000,n=10000
      integer :: i,j
      real (kind=8) :: starttime,endtime,time
      integer (kind=4) :: a

      call OMP_SET_NUM_THREADS(2)

      starttime=OMP_GET_WTIME()
!$OMP PARALLEL PRIVATE(i,j,a) DEFAULT(SHARED) 
!$OMP DO SCHEDULE(STATIC)
      do i=1,m
      do j=i,n
         a=i*j
      end do
      end do
!$OMP END DO 
!$OMP END PARALLEL 
      endtime=OMP_GET_WTIME()
      time=(endtime-starttime)*1000.
      print '(a,f13.5,a)','static schedule time=',time,'  milleseconds'

      starttime=OMP_GET_WTIME()
!$OMP PARALLEL PRIVATE(i,j,a) DEFAULT(SHARED) 
!$OMP DO SCHEDULE(DYNAMIC)
      do i=1,m
      do j=i,n
         a=i*j
      end do
      end do
!$OMP END DO
!$OMP END PARALLEL 
      endtime=OMP_GET_WTIME()
      time=(endtime-starttime)*1000.
      print '(a,f13.5,a)','dynamic schedule time=',time,'  milleseconds'

      starttime=OMP_GET_WTIME()
!$OMP PARALLEL PRIVATE(i,j,a) DEFAULT(SHARED) 
!$OMP DO SCHEDULE(GUIDED)
      do i=1,m
      do j=i,n
         a=i*j
      end do
      end do
!$OMP END DO 
!$OMP END PARALLEL 
      endtime=OMP_GET_WTIME()
      time=(endtime-starttime)*1000.
      print '(a,f13.5,a)','guided schedule time=',time,'  milleseconds'

      end program do_schdule

