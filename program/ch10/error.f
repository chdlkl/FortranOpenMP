!File: error.f
      program error
      implicit none
      real (kind=8) :: e,g,h
      real :: temp
      integer :: a(5),i

      i=6
    
      print '(a,i6,i6)','i,a(i)=',i,a(i)
    
      print '(a,f13.5)', 'temp=',temp

      print *, 'this is a test'     
      e=0
      g=1./e     

      e=-1.
      h=log(e)

      print *, e,g,h

      end program error
