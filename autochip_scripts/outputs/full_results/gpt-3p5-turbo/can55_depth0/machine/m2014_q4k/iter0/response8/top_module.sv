module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

	// 4-bit register
	reg [3:0] sr;

	// Update the register on the positive edge of the clock
	always @(posedge clk) begin
		// Reset the register when resetn is low
		if (resetn == 0)
			sr <= 4'b0000;
		else
			sr <= {sr[2:0], in};
	end

	// Output the most significant bit of the register
	assign out = sr[3];

endmodule
