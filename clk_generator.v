module clk_generator(cin,cout);
input  cin;
output reg cout= 0;
reg [24:0] counter = 0;

always @(posedge cin) 
begin
    if (counter == 0) begin
        counter <= 24999999;
        cout <= ~cout;
    end else begin
        counter <= counter -1;
    end
end
endmodule