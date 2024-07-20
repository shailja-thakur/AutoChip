module top_module (
	input clk,
	input in,
	output logic out
);

	// Initialize the output signal to 0
	initial begin
		out = 0;
	end

	// On the positive edge of the clock signal,
	// XOR the input signal with the current output signal
	always_ff @(posedge clk) begin
		out <= in ^ out;
	end

endmodule
