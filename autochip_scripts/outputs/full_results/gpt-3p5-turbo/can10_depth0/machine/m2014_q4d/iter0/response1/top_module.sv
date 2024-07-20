module top_module (
	input clk,
	input in,
	output logic out
);

	// Internal signal to store previous output
	logic prev_out;

	// D Flip-Flop
	always_ff @(posedge clk) begin
		prev_out <= out;
		out <= in ^ prev_out;
	end

endmodule
