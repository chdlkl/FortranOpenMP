! File: dce.f
      program dynamic_check_error

      call test

      end program dynamic_check_error

C----------------------------------------------------------
      subroutine test
      implicit none
      real (kind=8) :: e,f
      integer :: i

      do i=1,5
         e=i-3
         f=log(e) 
         print '(a,i6,e12.3,e12.3)','i,f=',i,e,f
      end do

      return
      end subroutine test
