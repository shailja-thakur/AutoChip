module top_module(
	input clk,
	input slowena,
	input reset,
	output reg [3:0] q);
	
	reg [3:0] count;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			count <= 4'b0000;
		else if (slowena)
			count <= count + 1;
	end

	assign q = count;
	
endmodule
