module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
	reg [3:0] sr;

	// Always block to update the shift register
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			sr <= 4'b0000;              // Reset the register to all zeros
		else
			sr <= {sr[2:0], in};        // Shift left and load input into LSB
	end

	// Output the most significant bit of the shift register
	assign out = sr[3];
endmodule
