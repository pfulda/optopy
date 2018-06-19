!   Program CombinedOpticalBenchWedged
!
!   Modeling a design for the lower optical bench for the MAHI experiment,
!   Where the interferometry happens.
!   

    use optocad
    use rsplot
!
    character(len=80)        :: ocd(80)=''
    real                     :: pst(5)

!                          ac     x     y   rd    ag      c  m    # label'
               
!	Reference laser input beam
    ocd(01)='b                  83.325,  76.65, 1.,  z=-1000., ag=90.         # Ref laser'
!     ocd(02)='i    beamcond.ocd, 210., 84., 0. # Beam conditioner @30,20'
    
! Probe laser input beam    
    ocd(02)='b                  165.6,  255.75, 1., z=-1000., ag=-90        # Probe laser'
!     ocd(04)='i    beamcond.ocd, -20., 140., 0. # Beam conditioner @30,20'

!Fiber collimators
	ocd(03)='c h, 83.325, 76.65, 10.0, 90., sc=13 # FC 2 @10,4'
	ocd(04)='c h, 165.6, 255.750, 10.0, 90., sc=13 # FC 1 @12,0'
! Pick off mirror 1
	ocd(05)='d srt, 165.4, 194.8, 12.7, -45., 0., 1, r=0.5, t=0.5 # PO1 @7,-7'
    ocd(06)='+    t, r=0., t=1., dm=5., ag=135.5 #PO1AR' 
! PBS
	ocd(07)='d srt, 124.503812, 195.000, 12.7, 135., 0., 1, r=0.5, t=0.5 # PBSAR @-20,-10'
	ocd(08)='+    t, r=0, t=1, dm=5., ag=-45.5 #PBSAR'
! beam dump for PBS open port
	ocd(09)='c d, 106.000, 197.000, 10.0, 0., sc=1 # PBSdump '
! W1
	ocd(12)='d r, 124.600, 122.400, 10.0, -90.0 # W1 @-4,-10'
   ocd(13)=' +   d, dx=5.'
! HWP
	ocd(14)='d t, 80.000, 190.000, 10.0, -90. #HWP @-20,-2'
   ocd(15)=' +   t, dx=2.'
! Pick off mirror 2
	ocd(16)='d srt, 83.325, 133.1008, 12.7, 135, 0., 1, r=0.5, t=0.5 # PO2 @-16,7'
	ocd(17)='+    tt, dm=5., ag=-45.5 #PO2AR'
! Steering mirror 1
	ocd(18)='d r, 81.00, 230.5456, 12.7, 135.530264, 0., 1, r=0.5, t=0.5 # SM1 @-16,7'
	ocd(19)='+    d, dm=6.'
! Interference beam splitter 1
	ocd(20)='d srti(ntr)str, 123.65, 230.247, 12.7, 135.2150375, 0., 1, r=0.5, t=0.5 # BS1 @9,16'
    ocd(21)='+          t, r=0, t=1, dm=5., ag=-45.5 #BS1AR'
! Interference beam splitter 2
	ocd(30)='d srti(ntr)str, 166.2, 135.5, 12.7, -135., 0., 1, r=0.5, t=0.5 # BS2 @10,-13'
    ocd(31)='+          t, r=0, t=1, dm=5., ag=45.5 #BS2AR'
! Steering mirror 3
	ocd(63)='d r, 272.000, 135.800, 12.7, -45., 0., 1, r=0.99, t=0.01 # SM3 @8,8'
 	ocd(64)='+    d, dm=6.35' 	
! PLL PD collimator
	ocd(56)='i bench.ocd, 264.000, 154.000, 0., 1., % width=16., height=30. '
	ocd(57)='c d, 272., 154., 8., 90. # FC3 @10,0'
! Beam dump for BS2       
	ocd(38)='c d, 162.000, 40.000, 10.0, 25.0, sc=1 # Dump 1 @0,0'
	ocd(39)='c d, 170.500, 40.000, 10.0, -25.0, sc=1 '
! Beam dump for BS1       '	
	ocd(61)='c d, 124.000, 280.000, 10.0, 205.0, sc=1 # Dump 2 @0,0'
	ocd(62)='c d, 115.500, 280.000, 10.0, 155.0, sc=1 '

! Gouy phase telescope lens 1
	ocd(42)='d t, 310., 229.203316, 12.7, 180.000, f=100. # L1 @-1,18'
	ocd(43)='+    t, dx=2.35'

    ! Gouy phase telescope lens 2
	ocd(44)='d t, 372., 229.203316, 12.7, 180.000, f=-50. # L2 @-1,18'
	ocd(45)='+    t, dx=2.35'

	! Pick off mirror 3
    ocd(46)='d    srt,  440.,  172., 12.7, -45., 0., 1, r=0.5, t=0.5 # PO3 @-16,7'
	ocd(47)='+    tt, dm=5. #PO3AR'

	! Steering mirror 4
	ocd(48)='d    r, 440.,  229.203316, 12.7, 45., 0., 1, r=0.99, t=0.01 # SM4 @8,8'
	ocd(49)='+    d, dm=6.35'
	
	! Gouy phase telescope lens 3
	ocd(50)='d    t,  400.,  92.442, 12.7, 180., f=50. # L3 @-20,0'
	ocd(51)='+    t, dx=4.35'

	! Steering mirror 5
	ocd(52)='d    r, 442.,  92., 12.7, -45., 0., 1, r=0.99, t=0.01 # SM5 @8,8'
	ocd(53)='+    d, dm=6.35'
	
	! QPD 1
	ocd(54)='i    qpd.ocd, 341.,  92.442, 180. # QPD1> @-4,-10'
	
	
	! QPD 2
	ocd(55)='i    qpd.ocd, 385.,  172.442, 180. # QPD2> @-4,-10'

    call oc_init('letter_p',unit='mm', psize=(/280. ,180./))     ! Initialize OPTOCAD (A4 portrait)
    call oc_frame(0.,0.,500.,300.,20.,20.,.5,ax='XY',gld=10.,fill=0)      ! Set up a frame
    call oc_set(fslb=1.5,write='rs s2 act rd an2 w2t w2s C2t C2s z2t_9 z2s_9 w0t_9 w0s_9 Gp2 tpp_9 ipp ph pw lb',print='Gp2 lb')
    call oc_input(ocd,nib)       ! This reads the data of the optical components
!
    lpba=ps_pattern('[30 10 8 10]0.')  ! Pattern for plotting the beam axis
    pst=(/1.e2,1.,1.e-2,1.e-4,1.e-6/)  ! Power steps for plotting the beam body

    
!	do ib=1,nib                        ! Trace and plot all beams
!		print ib
!		if (ib=1) then
			call oc_trace(1,of='refbeam.txt')                ! Trace all segments of the current beam
			call oc_beam(3.,fill=ps_color((/.8,.8,1./))) ! Plot outer part, ...
			call oc_beam(2.,fill=ps_color((/.6,.6,1./))) ! ... middle part, ...
			call oc_beam(1.,fill=4)                      ! ... inner part of the beam
			call oc_beam(0.,1,5,.2)          ! Plot the beam axes in black
			call oc_reset                    ! Prepare for repeated call of OC_TRACE
!		else
			call oc_trace(2,of='probebeam.txt')                ! Trace all segments of the current beam
			call oc_beam(3.,fill=ps_color((/1.,.8,.8/))) ! Plot outer part, ...
			call oc_beam(2.,fill=ps_color((/1.,.6,.6/))) ! ... middle part, ...
			call oc_beam(1.,fill=2)                      ! ... inner part of the beam
			call oc_beam(0.,1,5,.2)          ! Plot the beam axes in black
!			call oc_reset                    ! Prepare for repeated call of OC_TRACE
			
!		end if 
	      
!    end do

    call oc_surf(lw=.3)                ! Plot all surfaces with linewidth 0.3mm
!
    call oc_exit
    end
