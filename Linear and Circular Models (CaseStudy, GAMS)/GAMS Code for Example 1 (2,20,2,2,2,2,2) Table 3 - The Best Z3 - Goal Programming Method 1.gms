sets
a        /1*2/
i       /1*20/
j       /1*2/
k       /1*2/
l       /1*2/
r       /1*2/
w       /1*2/;

scalars
b /8/
S        /0.5/
alpha    /1.81875/
beta     /0.69768/
M        /10000000000/
p        /25/
C1       /74.65725168/
C11      /74.65725168/
C2       /149.3145034/
C3       /99.90896916/
C4       /199.8179383/
;




parameters
b
gl(l)
gj(j)
hj
hl
ej(j)
el(l)
dij(i,j)
dik(i,k)
Dkl(k,l)
Djw(j,w)
Dlw(l,w)
Daj(a,j)
Dal(a,l)
nn(a)
wh(w)
cw(w)
;

b     =normal(8,0.05);
gl(l) =normal(43930,1);
gj(j) =normal(1650,1);
hj    =normal(0.218,0.0001);
hl    =normal(0.218,0.0001);
ej(j) =normal(9,0.05);
el(l) =normal(9,0.05);

wh(w) =uniform(90000,7000000) ;
cw(w)=uniform(50000,1300000) ;

dij(i,j) =uniform(200,1000) ;
dik(i,k) =uniform(200,1000) ;
Dkl(k,l) =uniform(200,1000) ;
Djw(j,w) = uniform(200,1000) ;
Dlw(l,w) =uniform(200,1000) ;
Daj(a,j) = uniform(200,1000) ;
Dal(a,l) = uniform(200,1000) ;
nn(a)  =  uniform(200,600) ;



parameters
x(i)
Bk
Bj
Bl
Bw
Qij
Qik
Qkl
Qjw
Qlw
ok
oj
ol
ow
ck
cj
cl
wck(k)
wcj(j)
wcl(l)
wcw(w)
gamma
F(i)
;

gamma=6.278;

F(i) =107.267442 ;


Bk=1025;
Bj=1650 ;
Bl=1650;
Bw=43930 ;
Qij=14.991416;
Qik=14.991416;
Qkl=29.982832;
Qjw=20.062042;
Qlw=40.124084;

ok=2.20462;
oj=45.5474492;
ol=45.3600565;
ow=2;

ck=1;
cj=165139;
cl=802135;
*cw=0;

binary variables
zk(k)
zj(j)
zl(l)
zw(w)
;

free variables
z1
z2
z3
zt
pr
;
integer variables
nij(i,j)
nik(i,k)
nkl(k,l)
njw(j,w)
nlw(l,w)
paj(a,j)
pal(a,l)
pj(j)
pl(l)
ptj(j)
ptl(l)
;

positive variables
xij(i,j)
xik(i,k)
xkl(k,l)
yjw(j,w)
ylw(l,w)
yw(w)
yw_all
commuting
conversion
transportation
costTrasportaion
;



equations
obj1
obj2
obj3
TotalObj
***price
co1
co2
co3
co4
co6
co7
co8
co9
co10
co11
***co14
co15
cop15
co16
cop16
co17
cop17
co18
cop18
co19
cop19
co20
cop20
copp20
co21
cop21
copp21
co22
co23
co24
co25
co26
co27
co28
co31
co32
co33
co34
co35
co36
***co37
co100
co1000
co2000
co3000
co4000
co144
coz3
cozp3
cozpp3
cozppp3
;



obj1     ..      z1 =e=p*(sum((i,j),xij(i,j))+sum((i,k),xik(i,k)))
                         +sum((i,j),c1*dij(i,j)*nij(i,j))+sum((i,k),c1*dik(i,k)*nik(i,k))
                         +sum((k,l),c2*dkl(k,l)*nkl(k,l))+sum((j,w),c3*djw(j,w)*njw(j,w))+sum((l,w),c4*dlw(l,w)* nlw(l,w))
                         +sum(k,ck*zk(k))+sum(l,cl*zl(l))+ sum(j,cj*zj(j))+ sum(w,cw(w)*zw(w))
                         +[ok*sum((i,k),xik(i,k))]+[oj*sum((j,w),yjw(j,w))]
                         +[ol*sum((l,w),ylw(l,w))]+ [ow*sum(w,yw(w))];

obj2     ..      z2 =e= alpha*[(sum((a,j),daj(a,j)*paj(a,j))+sum((a,l),dal(a,l)*pal(a,l)))]
                        +beta*[sum(w,yw(w))]
                        +[gamma*sum((i,j),dij(i,j)*nij(i,j))]+[gamma*sum((i,k),dik(i,k)*nik(i,k))]
                        +[gamma*sum((k,l),dkl(k,l)*nkl(k,l))]+[gamma*sum((j,w),djw(j,w)*njw(j,w))]+[gamma*sum((l,w),dlw(l,w)*nlw(l,w))] ;

obj3     ..      z3 =e= sum(j,ptj(j))+sum(l,ptl(l))+[9*(sum(j,zj(j))+sum(l,zl(l)))];



TotalObj        ..      ZT =e= [1/3*(z1/8447534.7918)]+[1/3*(z2/ 578794.7132)]-[1/3*(z3/66)];

co1(i)  ..      sum(j,xij(i,j))+sum(k,xik(i,k)) =g= f(i);
co2(k)  ..      sum(i,xik(i,k)) =l= Bk;
co3(j)  ..      sum(i,xij(i,j)) =l= Bj;
co4(l)  ..      sum(k,xkl(k,l)) =l= Bl;
co100(w) ..     sum(l,ylw(l,w))+sum(j,yjw(j,w)) =l= Bw;
co6(k)  ..      sum(i,xik(i,k)) =E= sum(l,xkl(k,l));
co7(w)  ..      sum(j,yjw(j,w))+sum(l,ylw(l,w)) =e= yw(w);
co8(j)  ..    s*sum(i,xij(i,j)) =e= sum(w,yjw(j,w));
co9(l)  ..    s*sum(k,xkl(k,l)) =e= sum(w,ylw(l,w));
co10(j) ..      sum(w,yjw(j,w)) =l= gj(j);
co11(l) ..      sum(w,ylw(l,w)) =l= gl(l);
****co20(j)  ..     sum(a,paj(a,j))=e=ej(j)*zj(j)+[sum(w,hj*yjw(j,w))/b];
****co21(l)  ..     sum(a,pal(a,l))=e=el(l)*zl(l)+[sum(w,hl*ylw(l,w))/b];

co144(a) ..     sum(j,paj(a,j))+sum(l,pal(a,l)) =L= nn(a);
****co14(a) ..     sum(j,paj(a,j)) =L= nn(a);
****co37(a) ..     sum(l,pal(a,l)) =L= nn(a);

*************************Linearization*********************************
co20(j)  ..    sum(a,paj(a,j))=l=ej(j)*zj(j)+[pj(j)]+eps;
cop20(j)    .. pj(j)=g= [sum(w,hj*yjw(j,w))/b]+eps;
copp20(j)   .. pj(j)=l= [sum(w,hj*yjw(j,w))/b]+1;

co21(l)  ..    sum(a,pal(a,l))=e=el(l)*zl(l)+[pl(l)];
cop21(l) ..    pl(l)=g= [sum(w,hj*ylw(l,w))/b]+eps;
copp21(l) ..   pl(l)=l= [sum(w,hl*ylw(l,w))/b]+1;

co15(i,j)      ..      nij(i,j) =g= [xij(i,j)/qij]+eps;
cop15(i,j)     ..      nij(i,j) =l= [xij(i,j)/qij]+1;

co16(i,k)      ..      nik(i,k) =g= [xik(i,k)/qik]+eps;
cop16(i,k)     ..      nik(i,k) =l= [xik(i,k)/qik]+1;

co17(k,l)      ..      nkl(k,l) =g= [xkl(k,l)/qkl]+eps;
cop17(k,l)     ..      nkl(k,l) =l= [xkl(k,l)/qkl]+1;

co18(j,w)      ..      njw(j,w) =g= [yjw(j,w)/qjw]+eps;
cop18(j,w)     ..      njw(j,w) =l= {yjw(j,w)/qjw}+1;

co19(l,w)      ..      nlw(l,w) =g= [ylw(l,w)/qlw]+eps;
cop19(l,w)     ..      nlw(l,w) =l= [ylw(l,w)/qlw]+1;


coz3(j)        ..      ptj(j)=g= [(hj*sum(w,yjw(j,w)))/b]+eps;
cozp3(j)       ..      ptj(j)=l= [(hj*sum(w,yjw(j,w)))/b]+1;
cozpp3(l)      ..      ptl(l)=g= [(hl*sum(w,ylw(l,w)))/b]+eps;
cozppp3(l)     ..      ptl(l)=l= [(hl*sum(w,ylw(l,w)))/b]+1;


*************************Additional Constraints************************

co22(j) ..      sum(a,paj(a,j)) =l= M*zj(j);
co23(l) ..      sum(a,pal(a,l)) =l= M*zl(l);
co24(k) ..      sum(i,xik(i,k)) =l= M*zk(k);
co25(j) ..      sum(i,xij(i,j)) =l= M*zj(j);
co26(l) ..      sum(k,xkl(k,l)) =l= M*zl(l);
co27(w) ..      sum(j,yjw(j,w)) =l= M*zw(w);
co28(w) ..      sum(l,ylw(l,w)) =l= M*zw(w);
co31(w) ..      sum(j,yjw(j,w)) =l= wh(w);
co32(w) ..      sum(l,ylw(l,w)) =l= wh(w);
co33(k)  ..     zk(k) =l= 1;
co34(j)  ..     zj(j) =l= 1;
co35(l)  ..     zl(l) =l= 1;
co36(w) ..      zw(w) =l= 1;


***************************Additional Results**************************
co1000    ..      yw_all=e=sum(w,yw(w)) ;
****price    ..      pr=e= ZT/(0.26417205235815*1000*yw_all) ;
co2000   ..      commuting =e= alpha*[(sum((a,j),daj(a,j)*paj(a,j))+sum((a,l),dal(a,l)*pal(a,l)))];
co3000   ..      conversion =e=  beta*[sum(w,yw(w))];
co4000   ..      transportation =e= [gamma*sum((i,j),dij(i,j)*nij(i,j))]+[gamma*sum((i,k),dik(i,k)*nik(i,k))]+[gamma*sum((k,l),dkl(k,l)*nkl(k,l))]+[gamma*sum((j,w),djw(j,w)*njw(j,w))]+[gamma*sum((l,w),dlw(l,w)*nlw(l,w))] ;

***************************************************************


model   Linear   /all/

options
optca=0
optcr=0
reslim=500000
limrow=10000
limcol=10000
MIP=CPLEX
decimals=5
;


solve Linear using MIP maximizing z3 ;
display ZT.l,z1.l,z2.l,z3.l,zk.l,zj.l,zl.l,zw.l,paj.l,pal.l,xij.l,xik.l,xkl.l,yjw.l,ylw.l,yw.l,nij.l,yw_all.l,commuting.l,conversion.l,transportation.l




