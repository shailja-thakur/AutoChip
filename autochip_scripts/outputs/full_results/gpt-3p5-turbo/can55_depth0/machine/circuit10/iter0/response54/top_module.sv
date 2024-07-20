module top_module (
	input clk,
	input a,
	input b,
	output reg q,
	output reg state
);

	reg c;
	
	always @(posedge clk) begin
		c <= (a & b) | (a & c) | (b & c); // Register assignment for c
	end
	
	assign q = a ^ b ^ c; // Output assignment for q
	assign state = c; // Output assignment for state
	
endmodule
