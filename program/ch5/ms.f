! File: ms.f
      program multi_sections
      implicit none
      include 'omp_lib.h'

      integer :: tid,nthreads

      call OMP_SET_NUM_THREADS(6)
               
      print '(a)','Sections No.  section no.  nthreads   id'
      print '(a)','Sections A'
!$OMP PARALLEL PRIVATE(tid,nthreads)
!$OMP SECTIONS
!$OMP SECTION
         tid=OMP_GET_THREAD_NUM() 
         nthreads=OMP_GET_NUM_THREADS()
         print '(a,i8,i8)','               section 1',nthreads,tid
!$OMP SECTION
         tid=OMP_GET_THREAD_NUM() 
         nthreads=OMP_GET_NUM_THREADS()
         print '(a,i8,i8)','               section 2',nthreads,tid
!$OMP SECTION
         tid=OMP_GET_THREAD_NUM() 
         nthreads=OMP_GET_NUM_THREADS()
         print '(a,i8,i8)','               section 3',nthreads,tid
!$OMP END SECTIONS
!$OMP END PARALLEL 

      print '(a)','Sections B'
!$OMP PARALLEL PRIVATE(tid,nthreads)
!$OMP SECTIONS
!$OMP SECTION
         tid=OMP_GET_THREAD_NUM() 
         nthreads=OMP_GET_NUM_THREADS()
         print '(a,i8,i8)','               section 4',nthreads,tid
!$OMP SECTION
         tid=OMP_GET_THREAD_NUM() 
         nthreads=OMP_GET_NUM_THREADS()
         print '(a,i8,i8)','               section 5',nthreads,tid
!$OMP SECTION
         tid=OMP_GET_THREAD_NUM() 
         nthreads=OMP_GET_NUM_THREADS()
         print '(a,i8,i8)','               section 6',nthreads,tid
!$OMP END SECTIONS
!$OMP END PARALLEL 

      end program multi_sections
