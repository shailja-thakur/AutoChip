module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

	// 4-bit register to store data
	reg [3:0] sr;

	// Update register on positive edge of clock
	always @(posedge clk) begin
		if (resetn == 1'b0) begin
			// Reset register to all zeros
			sr <= 4'b0;
		end else begin
			// Shift left by one bit and load input into LSB
			sr <= {sr[2:0], in};
		end
	end

	// Output is the most significant bit of the register
	assign out = sr[3];

endmodule
