!File: mdt.f
      program monthe_date_time
      character(8)  :: date
      character(10) :: time
      character(5)  :: zone
      integer(kind=4),dimension(1:8) :: values

      call date_and_time(DATE=date,ZONE=zone)
      call date_and_time(TIME=time)
      call date_and_time(VALUES=values)
      print '(a)','year_month_date  time      time_zone'
      print '(a,8x,a,2x,a)', date, time, zone      
      print *

      print '(a)','year      month      date      timezone'
      print '(4(i5,5x))', (values(i),i=1,4)
      print *

      print '(a)','hour     minute     second     millisecond'
      print '(4(i5,5x))', (values(i),i=5,8)

      end program monthe_date_time
