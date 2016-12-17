module control(flag,led11,led12,led21,led22);
input flag;
output reg led11 = 1'b1;
output reg led12 = 1'b0;
output reg led21 = 1'b0;
output reg led22 = 1'b1;

always@(flag)
begin
if(flag == 1)begin
led11<=1'b0;
led12<=1'b1;
led21<=1'b1;
led22<=1'b0;
end
else begin
led11<=1'b1;
led12<=1'b0;
led21<=1'b0;
led22<=1'b1;
end
end

endmodule
