module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
	// Declare a 4-bit register
	reg [3:0] sr;
	
	always @(posedge clk, negedge resetn) begin
		if (!resetn) begin
			// Reset the register to all zeros
			sr <= 4'b0;
		end else begin
			// Shift the register left by one bit and load the input into the least significant bit
			sr <= {sr[2:0], in};
		end
	end
	
	// Assign the output to the most significant bit of the register
	assign out = sr[3];

endmodule
