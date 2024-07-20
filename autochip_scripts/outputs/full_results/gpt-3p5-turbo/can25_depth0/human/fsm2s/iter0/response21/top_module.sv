module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg [1:0] state;

always @(posedge clk or posedge reset)
    if (reset)
        state <= 2'b0;
    else if (state == 2'b00)
        state <= j ? 2'b10 : 2'b00; // OFF -> OFF or OFF -> ON
    else if (state == 2'b10)
        state <= k ? 2'b00 : 2'b10; // ON -> OFF or ON -> ON
        
assign out = (state == 2'b10) ? 1'b1 : 1'b0;
     
endmodule
