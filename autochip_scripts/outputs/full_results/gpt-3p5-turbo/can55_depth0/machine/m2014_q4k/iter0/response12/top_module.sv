module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
	// Declare a 4-bit register for storing the data
	reg [3:0] sr;

	// Update the register on positive edge of the clock signal
	always @(posedge clk) begin
		if (resetn == 0) begin
			// Reset the register to all zeros
			sr <= 4'b0;
		end else begin
			// Shift left by one bit and load the input into the least significant bit
			sr <= {sr[2:0], in};
		end
	end

	// Assign the most significant bit of the register to the output
	assign out = sr[3];

endmodule
