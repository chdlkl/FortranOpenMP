!File: mst.f
      program max_system_clock
      integer(kind=2) :: ic2,crate2,cmax2
      integer(kind=4) :: ic4,crate4,cmax4
      integer(kind=8) :: ic8,crate8,cmax8

      call system_clock(count=ic2, count_rate=crate2, count_max=cmax2)
      call system_clock(count=ic4, count_rate=crate4, count_max=cmax4)
      call system_clock(count=ic8, count_rate=crate8, count_max=cmax8)

      print *, ic2, crate2, cmax2
      print *,'Elapsed CPU time(max kind=2)='
      print *, cmax2/crate2,'seconds'
      print *

      print *, ic4, crate4, cmax4
      print *,'Elapsed CPU time(max kind=4)='
      print *, cmax4/crate4/60/60,'hours'
      print *

      print *, ic8, crate8, cmax8
      print *,'Elapsed CPU time(max kind=8)='
      print *, cmax8/crate8/60/60/24/365,'years'

      end program max_system_clock
