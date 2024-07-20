module top_module (
	input clk,
	input in,
	output logic out
);

	// Register to hold the output state
	reg q;

	// Initial block to set initial value of q
	initial begin
		q = 0;
	end

	// Always block triggered on the positive edge of the clock signal
	always @(posedge clk) begin
		q <= q ^ in;  // Toggle the output based on the input
	end

	// Assign the internal register q to the output
	assign out = q;

endmodule
