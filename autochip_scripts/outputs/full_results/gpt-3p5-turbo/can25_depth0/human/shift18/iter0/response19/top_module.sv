module top_module(
	input clk,
	input load,
	input ena,
	input [1:0] amount,
	input [63:0] data,
	output reg [63:0] q);

	// Internal signal to hold shifted data
	reg [63:0] shifted_data;

	always @(posedge clk)
	begin
		// Check if load is high, and load the data into the shift register
		if (load)
			q <= data;
		// Check if ena is high, and perform shift operation based on amount
		else if (ena)
		begin
			case (amount)
				2'b00: shifted_data <= q << 1;   // Shift left by 1 bit
				2'b01: shifted_data <= q << 8;   // Shift left by 8 bits
				2'b10: shifted_data <= q >> 1;   // Shift right by 1 bit (arithmetic right shift)
				2'b11: shifted_data <= q >> 8;   // Shift right by 8 bits (arithmetic right shift)
			endcase
			q <= shifted_data;
		end
	end

endmodule
