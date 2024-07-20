module top_module(
	input clk,
	input reset,
	output reg [31:0] q
);

	// Define internal signals
	reg [31:0] next_q;
	
	// Define the taps
	reg tap_32, tap_22, tap_2, tap_1;

	// Define the feedback XOR gates
	reg xor_32, xor_22, xor_2, xor_1;

	always @(posedge clk) begin
		if (reset) begin
			q <= 32'b1;
		end else begin
			tap_32 <= q[31];
			tap_22 <= q[21];
			tap_2 <= q[1];
			tap_1 <= q[0];
			
			xor_32 <= tap_32 ^ q;
			xor_22 <= tap_22 ^ q;
			xor_2 <= tap_2 ^ q;
			xor_1 <= tap_1 ^ q;
			
			next_q = {xor_32, q[31:1]};
			
			q <= next_q;
		end
	end
endmodule
