function input=wlt4(a);
[LL,LH,HL,HH]=dwt2(a,'haar');

[LL1,LH1,HL1,HH1]=dwt2(LL,'haar');
[LL2,LH2,HL2,HH2]=dwt2(LL1,'haar');

[LL3,LH3,HL3,HH3]=dwt2(LL2,'haar');
input=LL3;