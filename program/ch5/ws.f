! File: ws.f
      program workshare
      implicit none
      include 'omp_lib.h'

      integer, parameter :: l=80, m=80, n=80 
      integer :: i,j,k
      integer (kind=4), dimension(1:l, 1:m, 1:n) :: a,b,c,d

      real (kind=8) :: starttime,endtime,time

      call OMP_SET_NUM_THREADS(4)

      do k=1,n
      do j=1,m
      do i=1,l
         a(i,j,k)=i
         b(i,j,k)=j
      enddo
      enddo
      enddo

       starttime=OMP_GET_WTIME()
!$OMP PARALLEL PRIVATE(k) SHARED(i,j,a,b,c,d)
!$OMP DO
      do k=1,n
      do j=1,m
      do i=1,l
         c(i,j,k)=a(i,j,k)*b(i,j,k)+a(i,j,k)
         d(i,j,k)=a(i,j,k)**2-b(i,j,k)**2
      enddo
      enddo
      enddo

!$OMP END DO
!$OMP END PARALLEL
      endtime=OMP_GET_WTIME()
      time=(endtime-starttime)*1000.
      print '(a)','--------parallel do'
      print '(a,f13.5,a)','static schedule time=',time,'  milleseconds'

      print '(a,i15,i15)','a(l,m,n),b(l,m,n)=',a(l,m,n),b(l,m,n)
      print '(a,i15,i15)','c(l,m,n),d(l,m,n)=',c(l,m,n),d(l,m,n)
      print *
 
       starttime=OMP_GET_WTIME()
!$OMP PARALLEL SHARED(a,b,c,d)
!$OMP WORKSHARE
      c=a*b+a
      d=a**2-b**2
!$OMP END WORKSHARE NOWAIT
!$OMP END PARALLEL
      endtime=OMP_GET_WTIME()
      time=(endtime-starttime)*1000.
      print '(a)','--------parallel workshare'
      print '(a,f13.5,a)','static schedule time=',time,'  milleseconds'

      print '(a,i15,i15)','a(l,m,n),b(l,m,n)=',a(l,m,n),b(l,m,n)
      print '(a,i15,i15)','c(l,m,n),d(l,m,n)=',c(l,m,n),d(l,m,n)

      end program workshare
