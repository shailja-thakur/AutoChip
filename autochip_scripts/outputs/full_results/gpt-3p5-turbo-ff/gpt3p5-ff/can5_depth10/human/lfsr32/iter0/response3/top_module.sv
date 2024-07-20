module top_module(
	input clk,
	input reset,
	output reg [31:0] q);
	
	reg [31:0] feedback;
	
	always @(posedge clk or posedge reset) begin
		if(reset)
			q <= 32'h1;
		else begin
			feedback[31] <= q[0] ^ q[30] ^ q[20] ^ q[0];
			feedback[30:1] <= q[31:1];
			q <= feedback;
		end
	end
	
endmodule
