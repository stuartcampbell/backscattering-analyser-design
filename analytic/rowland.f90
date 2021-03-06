! Program to generate the parameters for an analyser bank (IRIS/OSIRIS)
! Circle centred on the point midway between the sample and detector.  

PROGRAM rowland    
IMPLICIT NONE         
INTEGER :: n, i   
REAL :: xd, yd, xo, yo, ystart, sa, radius   
REAL, ALLOCATABLE :: x(:), y(:), phi(:)   
CHARACTER(len=80) :: filename

WRITE(6,*) ' How many analyser crystals ?'	
READ(5,*) n		ALLOCATE(x(n),y(n),phi(n))
WRITE(6,*) ' Output filename ?'	
READ(5,'(A80)') filename      

OPEN(unit=50,file=filename,status='new')	

WRITE(6,*) ' Coordinates of detector ?'	
READ(5,*) xd, yd	

WRITE(6,*) ' Maximum y-coord of analyser bank ?'	
READ(5,*) ystart	
WRITE(6,*) ' Distance from sample to analyser at y=0 ?'	
READ(5,*) sa
! Calculate coordinates of the circles.	
xo = xd / 2.0	
yo = yd / 2.0	
WRITE(6,*) ' Centre of circle @ ',xo,yo		
radius = sqrt(((sa-xo)**2) + ((-yo)**2))	
WRITE(6,*) ' Radius of circle = ',radius      
DO i = 1, n 	  
    y(i) = ystart - (i-1) - 0.5	  
    x(i) = sqrt(radius**2 - (y(i)-yo)**2) + xo        
    phi(i) = -(atan((y(i)-yo)/(x(i)-xo)))/0.01745329251	  
    write(6,100) x(i), y(i), phi(i)	  
    write(50,100) x(i), y(i), phi(i)	
ENDDO      

100	FORMAT(1X,F7.3,1X,F7.3,1X,F7.3) 	

CLOSE(50)  
END PROGRAM rowland
