module top_module (
	input clk,
	input in,
	output logic out
);

	// internal register to hold the state of the output signal
	logic reg_out;

	always_ff @(posedge clk) begin
		// toggle the output signal based on the input and previous output
		reg_out <= in ^ reg_out;
	end

	// assign the output signal to the reg_out
	assign out = reg_out;

endmodule
