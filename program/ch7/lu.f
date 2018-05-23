! File: lu.f
      program lock_unblock 
      include 'omp_lib.h'
      integer (OMP_LOCK_KIND) :: lck
      integer :: idcpu,mcpu,counter,i

      call OMP_SET_NUM_THREADS(8)

      call OMP_INIT_LOCK(lck) 

      counter=0
!$OMP PARALLEL PRIVATE(idcpu,i) SHARED(lck) FIRSTPRIVATE(counter)
         idcpu=OMP_GET_THREAD_NUM() 

         do while (.not. OMP_TEST_LOCK(lck)) 
c this thread does not yet have the lock, so it must do something else.
            print *
            print '(a,i5,a)','thread id',idcpu,' does not have a lock'
            print *
            counter=counter+1
         end do
c this thread now has the lock and can do the work.
         print '(a,i5,a)','thread id',idcpu,' has a lock'
         print '(a,i5,a)','       counter=',counter
         print '(a,i5,a)','thread id',idcpu,' released a simple lock'

         call OMP_UNSET_lock(lck) 
!$OMP END PARALLEL

      call OMP_DESTROY_LOCK(lck) 

      end program lock_unblock
