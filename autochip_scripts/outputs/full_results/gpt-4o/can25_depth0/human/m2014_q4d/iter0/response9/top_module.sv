module top_module (
	input clk,
	input in,
	output logic out
);

	// Intermediate signal for the XOR output
	wire xor_out;
	
	// XOR the input 'in' with the current output 'out' of the flip-flop
	assign xor_out = in ^ out;
	
	// D Flip-Flop: on the positive edge of the clock, the output takes the XOR result
	always_ff @(posedge clk) begin
		out <= xor_out;
	end

endmodule
