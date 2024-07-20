module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
	// Define a 4-bit register
	reg [3:0] sr;

	// Assign the output to the most significant bit of the register
	assign out = sr[3];

	// Synchronize the shift register on the positive edge of the clock signal
	always @(posedge clk) begin
		// Reset the register to all zeros when resetn is low
		if (resetn == 0) begin
			sr <= 4'b0000;
		end
		// Shift the register left by one bit and load the input when resetn is high
		else begin
			sr <= {sr[2:0], in};
		end
	end
endmodule
