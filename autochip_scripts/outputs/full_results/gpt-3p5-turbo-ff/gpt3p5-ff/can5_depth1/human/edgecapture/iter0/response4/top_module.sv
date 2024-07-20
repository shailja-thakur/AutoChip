module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);

    reg [31:0] temp;
	initial 
	    temp = 0;

	always @(posedge clk or posedge reset)
	begin
	    if (reset)
	        temp <= 0;
	    else
	        temp <= in;
	end

	always @(posedge clk or posedge reset)
	begin
	    if (reset)
	        out <= 0;
	    else
	        out <= temp & (~in);
	end

endmodule
