module timer( count1Hi, count1Lo, count2Hi, count2Lo,  clock,outHi , outLo,flag );
input[3:0] count1Hi;
input [3:0]count1Lo;
input [3:0]count2Hi;
input[3:0] count2Lo;
input clock;
output reg [3:0] outHi = 0;
output reg  [3:0] outLo  = 0;
output reg flag=0;
reg [9:0]out = 0;

always@(posedge clock)
begin
	if(outHi==0 && outLo==0)
	begin
		if(flag)
			begin
				out<=(count1Hi*10+count1Lo)*5;
			end
		else 
		begin
			out<=(count2Hi*10+count2Lo)*5;
		end
		if(out>90)
				out<=90;
		outLo<=out%10;
		outHi<=out/10;
		flag<=~flag;
	end
	else
	if(outLo>0)
		outLo<=outLo-1;
	else if(outLo==0)
		begin
		outLo<=9;
		outHi<=outHi-1;
		end
		
end	
endmodule