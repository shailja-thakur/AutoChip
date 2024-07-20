module top_module (
	input clk,
	input in,
	output logic out
);

	// Internal wire to hold the result of XOR operation
	logic xor_out;

	// XOR operation
	assign xor_out = in ^ out;

	// D flip-flop
	always_ff @(posedge clk) begin
		out <= xor_out; 
	end
	
endmodule
