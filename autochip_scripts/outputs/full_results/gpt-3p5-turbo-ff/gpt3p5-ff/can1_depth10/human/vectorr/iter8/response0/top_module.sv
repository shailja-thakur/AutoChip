module top_module (
	input [7:0] in,
	output [7:0] out
);

	// Use a for loop to reverse the bit ordering
	// Iterate from 0 to 7
	integer i;
	assign out = {in[7], in[6], in[5], in[4], in[3], in[2], in[1], in[0]};

	// Add delays to the input and output assignments inside a testbench
	initial begin
		// Initialize inputs
		assign in = 8'b01010101;

		// Wait for 1 time unit
		#1;

		// Print output
		$display("out = %b", out);

		// Finish simulation
		$finish;
	end

endmodule
