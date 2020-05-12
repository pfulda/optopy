import numpy as np
import os
import platform
import re

pi=np.pi

class ocd(object):
	
	def __init__(self,ocdfile=None):
	
		self.lines=None
		self.source_file=None
		self.output_file=None
		self.data_files=None

	# def save(self, filename=None):
 #        """
 #        Saves the current ocd object to a file. 
 #        """
 #        with open(filename,'w') as ocdfile:
 #            ocdfile.writelines(ocd_lines)


	def load_ocd_file(self,ocdfile=None):
	
		self.lines=None
		fid=open(ocdfile+'.f90','r')
		self.lines=fid.readlines()
		fid.close()
		self.source_file=ocdfile

		# check for output data files specified in .f90

		data_files=[]

		for linenum,line in enumerate(self.lines):

			if 'oc_trace' in line:
		#         print('Found oc_trace in line {}'.format(linenum))
				for wordnum,word in enumerate(re.split('\(|,|\)',line)):
					if 'of' and '=' in word:
						fname=re.findall(r'\'(.*?)\'', word)
				if data_files==[]:
					data_files=[fname[0]]
				else:
					data_files.append(fname[0])
        
		self.data_files=data_files  # list of output files is added to the ocd object.





	def print_ocd_file(self):

		for line in self.lines:
			print(line)		


	def replace_lines(self,linenums,newlines):
	
		for (newline,linenum) in zip(newlines,linenums):
			self.lines[linenum]=newline+'\n'

	def run_ocd_file(self,newocdfile=None,verbose=True):
		
		if newocdfile is None:
			if self.output_file is None:
				print('No output file given, running as temp.f90')
				self.output_file='temp'
			else:
				print('Running as '+self.output_file+'.f90')
		else:
			self.output_file=newocdfile
			print('Running as '+self.output_file+'.f90')


		fid=open(self.output_file+'.f90','w')
		for line in self.lines:
			fid.write(line)
		fid.close()
	
		stream = os.popen('occr '+self.output_file+'.f90')
		output = stream.read()
		
		if platform.system() == "Darwin":
			print('Converting from ps to pdf')
			stream2 = os.popen('ps2pdf '+self.output_file+'.ps '+self.output_file+'.pdf ')
			output2 = stream2.read()
			print(output2)


		if verbose:
			print(output)
			print(output2)

		return output

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

