! File: lm.f
      program lock_max
      include 'omp_lib.h'
      parameter(m=1000)

      integer lck 
      integer idcpu,mcpu,i,a(m),max,imax

!$OMP PARALLEL DO PRIVATE(idcpu,i) SHARED(a)
      do i=1,m
            idcpu=OMP_GET_THREAD_NUM() 
            a(i)=idcpu+i+idcpu*i
      end do
!$OMP END PARALLEL DO

      print '(a)','------------series program------------'
      max=-1
      imax=-1
      do i=1,m
         if(a(i).ge.max)then
            max=a(i)
            imax=i
         end if
      end do
      print '(a,i5,i5)','max,imax=',max,imax
      print *

      call OMP_SET_NUM_THREADS(8)

      print '(a)','----parallel program without lock-----'
      max=-1
      imax=-1
!$OMP PARALLEL DO PRIVATE(i) SHARED(max,imax,a)
      do i=1,m
         if(a(i).ge.max)then
            max=a(i)
            imax=i
         end if
      end do
!$OMP END PARALLEL DO
      print '(a,i5,i5)','max,imax=',max,imax
	print *

      print '(a)','------parallel program with lock------'
      call OMP_INIT_LOCK(lck) 

      max=-1
      imax=-1
!$OMP PARALLEL DO PRIVATE(i) SHARED(max,imax,a)
      do i=1,m
         call OMP_SET_LOCK(lck) 
         if(a(i).ge.max)then
            max=a(i)
            imax=i
         end if
          call OMP_UNSET_LOCK(lck) 
      end do
!$OMP END PARALLEL DO
      call OMP_DESTROY_LOCK(lck) 

      print '(a,i5,i5)','max,imax=',max,imax

      end program lock_max

