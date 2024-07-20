module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
	// 4-bit register to store data
	reg [3:0] sr;

	// Always block triggered on the positive edge of the clock
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			// When reset is low, reset the register to 0
			sr <= 4'b0000;
		else
			// Shift left and input the new bit
			sr <= {sr[2:0], in};
	end
	
	// Output the most significant bit of the shift register
	assign out = sr[3];

endmodule
