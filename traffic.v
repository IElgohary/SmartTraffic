module traffic(clk,s11,s12,s21,s22,led11,led12,led21,led22,c1lo,c1hi,c2lo,c2hi,tlo,thi,ss,ss2,leds);
input wire clk,s11,s12,s21,s22;
output wire led11,led12,led21,led22;
output reg [3:0]leds;
output wire[6:0] c1lo,c1hi,c2lo,c2hi,tlo,thi,ss,ss2;
wire clkhz; 
wire flag;
wire statehi,statelo;
wire [3:0] c1hitemp, c2hitemp, c1lotemp,c2lotemp,thitemp,tlotemp; 

clk_generator c(clk,clkhz);

second1 s1(clkhz,s11,s12,c1lotemp,c1hitemp);
seven_segment_decoder d1 (c1hitemp,c1hi);
seven_segment_decoder d2 (c1lotemp,c1lo);

second1 s2(clkhz,s21,s22, c2lotemp,c2hitemp);
seven_segment_decoder d3 (c2hitemp,c2hi);
seven_segment_decoder d4 (c2lotemp,c2lo); 

timer t(c1hitemp,c1lotemp,c2hitemp,c2lotemp,clkhz,thitemp,tlotemp,flag);
control con(flag,led11,led12,led21,led22);


seven_segment_decoder d5 (thitemp,thi);
seven_segment_decoder d6 (tlotemp,tlo); 

//seven_segment_decoder d7 (statehi,ss2);
//seven_segment_decoder d8 (statelo,ss);


endmodule