! File: vector.f
      program vector
      integer, parameter :: m=500
      integer :: i

      real (kind=8), dimension(1:m) :: a,b,c,d,x
      real (kind=8) :: e

c------loop 1--------
      do i=1,m
         a(i)=1.0
         b(i)=2.0
      end do

      a=1.0
      c=3.0
      d=a+c
      b=sqrt(c)

c------loop 2--------
      do i=2,200
         a(i)=b(i)*m+d(i)
         b(i)=(a(i)+b(i))/2.
         e=e+b(i)
      end do

c------loop 3--------
      do i=2,200
         a(i)=b(i)*m+d(i)
      end do
c------loop 4--------
      do i=2,200
         b(i)=(a(i)+b(i))/2.
      end do
c------loop 5--------
      do i=2,200
         e=e+b(i)
      end do

c------loop 6--------
      do i=2,200
         a(i+1)=a(i)+e
      end do

c------loop 7--------
      i=0
      do while(i<10)
         a(i)=d(i)*c(i+1)
         if (a(i)<0) then
           a(i)=0
         end if
         i=i+1
      end do

c------loop 8--------
      i=300
      do while(i>200)
         a(i)=b(i)+c(i+1)
         if (a(i)>0) then
           exit
         end if
         i=i-1
      end do

c------loop 9--------
      i=0
      do while(i<10-i)
        a(i)=d(i)+c(i+1)
        if (a(i)<0) then
          a(i)=0
        end if
        i=i+1
      end do

c------loop 10--------
      j=100
      do i=0,10
        a(i)=a(i+j)
      end do

c------loop 11--------
      j=100
!DEC$ IVDEP
      do i=0,10
        a(i)=a(i+j)
      end do

c------loop 12--------
      j=100
!DIR$ SIMD
      do i=0,10
        a(i)=a(i+j)
      end do

c------loop 13--------
!DEC$ NOVECTOR
      do i=1,100
        a(i)=b(i)+c(i)
      end do

      end program vector
