module Sensor(clk,sensorIn,  sensorDec, countHi,countLo,curr[1],curr[0] );
input sensorIn;
input sensorDec;
reg total = 10'd0;
input clk ;
output reg [1:0]curr;
reg [1:0] nxt;
output reg  [3:0]countHi ;
output reg  [3:0]countLo ;
parameter s_idle=2'b00 , s_in=2'b01 , s_out=2'b10 , s_in_out=2'b11;

//start of comment

//case(countHi) 
//						4'b0000: begin countHi <= 4'b0001; end 
//						4'b0001: begin countHi <= 4'b0010; end 
//						4'b0010: begin countHi <= 4'b0011; end 
//						4'b0011: begin countHi <= 4'b0100; end 
//						4'b0100: begin countHi <= 4'b0101; end 
//						4'b0101: begin countHi <= 4'b0110; end
//						4'b0110: begin countHi <= 4'b0111; end
//						4'b0111: begin countHi <= 4'b1000; end
//						4'b1000: begin countHi <= 4'b1001; end
//						4'b1001: begin countHi <= 4'b0000; end
//						default: begin countHi <= 4'b0000; end 
//		endcase
//		
//		case(countLo) 
//						4'b0000: begin countLo <= 4'b0001; end 
//						4'b0001: begin countLo <= 4'b0010; end 
//						4'b0010: begin countLo <= 4'b0011; end 
//						4'b0011: begin countLo <= 4'b0100; end 
//						4'b0100: begin countLo <= 4'b0101; end 
//						4'b0101: begin countLo <= 4'b0110; end
//						4'b0110: begin countLo <= 4'b0111; end
//						4'b0111: begin countLo <= 4'b1000; end
//						4'b1000: begin countLo <= 4'b1001; end
//						4'b1001: begin countLo <= 4'b0000; end
//						default: begin countLo <= 4'b0000; end 
//		endcase
// end of comment

always@(curr)
begin

	if(curr == s_idle)begin
		if({sensorIn,sensorDec} == 2'b00) nxt <= s_in_out;
		if({sensorIn,sensorDec} == 2'b01) nxt <= s_out;
		if({sensorIn,sensorDec} == 2'b10) nxt <= s_in;
		if({sensorIn,sensorDec} == 2'b11) nxt <= s_idle;
	end
	if(curr == s_in)begin
		if({sensorIn,sensorDec} == 2'b00) nxt <= s_in_out;
		if({sensorIn,sensorDec} == 2'b01) begin
		if(countLo<9)
begin
countLo=countLo+1;end
else if(countLo==9) 
begin countLo=0;
countHi=countHi+1; end nxt<= s_out; end
		if({sensorIn,sensorDec} == 2'b10) nxt <= s_in;
		if({sensorIn,sensorDec} == 2'b11) begin if(countLo<9)
begin
countLo=countLo+1;end
else if(countLo==9) 
begin countLo=0;
countHi=countHi+1; end nxt <= s_idle; end
	end
	if(curr == s_out)begin
		if({sensorIn,sensorDec} == 2'b00) nxt <= s_in_out;
		if({sensorIn,sensorDec} == 2'b01) nxt <= s_out;
		if({sensorIn,sensorDec} == 2'b10) nxt <= s_in;
		if({sensorIn,sensorDec} == 2'b11) begin if(countLo>0)
begin
countLo=countLo-1; end
else if(countLo==0) begin
countLo=9;
countHi=countHi-1; 
end nxt<= s_idle; end
	end
	if(curr == s_in_out)begin
		if({sensorIn,sensorDec} == 2'b00) nxt <= s_in_out;
		if({sensorIn,sensorDec} == 2'b01) begin if(countLo<9)
begin
countLo=countLo+1;end
else if(countLo==9) 
begin countLo=0;
countHi=countHi+1; end nxt<= s_out; end
		if({sensorIn,sensorDec} == 2'b10) begin if(countLo>0)
begin
countLo=countLo-1; end
else if(countLo==0) begin
countLo=9;
countHi<=countHi-1; 
end nxt <= s_in; end
		if({sensorIn,sensorDec} == 2'b11) nxt<= s_idle;
	end
	


 	
end

always@(posedge clk)
	begin
		curr <= nxt;
	end


endmodule

