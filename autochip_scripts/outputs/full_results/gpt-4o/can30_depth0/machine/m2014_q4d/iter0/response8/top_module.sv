module top_module (
	input clk,
	input in,
	output logic out
);
	// Internal register to hold the state of the output
	logic q;

	// Initial block to set the initial state of the output
	initial begin
		q = 0;
		out = 0;
	end

	// Always block sensitive to the positive edge of the clock signal
	always_ff @(posedge clk) begin
		q <= q ^ in;
		out <= q;
	end
endmodule
