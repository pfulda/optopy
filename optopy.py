import numpy as np
pi=np.pi

def replace_lines(ocdfile,linenums,newlines):
	
	fid=open(ocdfile,'r')
	lines=fid.readlines()
	fid.close()

	for (newline,linenum) in zip(newlines,linenums):
		lines[linenum-1]=newline+'\n'

	return lines

def hermite_polyval(x,n):

	a=np.zeros((n+1))
	a[n]=1
	return np.polynomial.hermite.hermval(x,a)

def un(lam,q,x,n):
	
	k=2.*pi/lam
	q0=1j*q.imag
	
	w0=np.sqrt(lam/pi*q0.imag)
	
	w=np.sqrt(lam/pi*(q*np.conj(q))/q.imag)

	fieldpre=(2./pi)**(0.25)/np.sqrt(2**n*np.math.factorial(n)*w0)*np.sqrt(q0/q)*(q0/np.conj(q0)*(np.conj(q)/q))**(n/2.)
	field=fieldpre*hermite_polyval(np.sqrt(2.)*x/w,n)*np.exp(-1j*k*x*x/2.0/q)

	return field

def unm(lam,qx,qy,x,y,n,m):

	field=un(lam,qx,x,n)*un(lam,qy,y,m);

	return field

def HGfield(lam, qs ,n ,m ,x ,y, offset):
 	
 	xpoints=len(x);
  	ypoints=len(y);
  
  	field=np.zeros((ypoints,xpoints))
  	field=field+0*1j

  	x=x-offset[0];
  	y=y-offset[1];

  	for i, yval in enumerate(y):
  	
  		field[i-1,:]=unm(lam,qs[0], qs[1], x, yval, n, m)

  	return field

def w0z_to_q(w0,z,lam):
	
	zR=pi*w0**2/lam
	q=1j*zR+z

	return q

def q_to_gouy(q,lam):

	gouy=np.arctan(q.real/q.imag)
	return gouy

def q_to_w(q,lam):

	w = np.sqrt(lam/pi*np.abs(q**2.)/q.imag)

	return w

def q_thinlens(qin,f,lam):

	qout = qin / (-qin/f + 1)

	return qout

