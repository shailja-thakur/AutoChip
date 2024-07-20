module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

	// Declaration of internal wires
	wire [3:0] sr;

	// Register update process
	always @(posedge clk) begin
		if (resetn == 0) begin
			sr <= 4'b0000; // Reset the register to all zeros
		end else begin
			sr <= {sr[2:0], in}; // Shift left by one bit and load in the input
		end
	end

	// Assign the output to the most significant bit of the register
	assign out = sr[3];

endmodule
