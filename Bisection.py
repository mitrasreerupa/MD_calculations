#Bisection method - to find the root of the equation x^2-4x- 10=0
x1=float(input("x1="))
x2=float(input("x2="))
x0=(x1+x2)/2
fx0=x0**2-4*x0-10
fx1=x1**2-4*x1-10
fx2=x2**2-4*x2-10
n=1
while True:
    if abs(fx0)<0.00001:
        break
    elif (fx0*fx1)<0:
        x2=x1
        x1=x0
        x0=(x1+x2)/2
        fx0=x0**2-4*x0-10
        fx1=x1**2-4*x1-10
        fx2=x2**2-4*x2-10
    elif (fx0*fx2)<0:
        x2=x2
        x1=x0
        x0=(x1+x2)/2
        fx0=x0**2-4*x0-10
        fx1=x1**2-4*x1-10
        fx2=x2**2-4*x2-10
    print("x1=",x1,"\tx2=",x2)
    n+=1
print("\nThe roots of x=",x1)
print(f"Function value at {x1}={fx1} \n")
print("No. of iterations:",n)
