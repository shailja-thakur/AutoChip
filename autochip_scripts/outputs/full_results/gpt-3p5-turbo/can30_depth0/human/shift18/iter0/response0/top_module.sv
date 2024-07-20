module top_module(
	input clk,
	input load,
	input ena,
	input [1:0] amount,
	input [63:0] data,
	output reg [63:0] q);

   // Internal signals
   reg [63:0] shift_reg;

	// Clock edge detection
	always @(posedge clk)
	begin
		// Load shift register with data
		if (load)
			shift_reg <= data;
		// Shift the shift register
		else if (ena)
		begin
			case (amount)
				2'b00: shift_reg <= shift_reg << 1;       // Shift left by 1 bit
				2'b01: shift_reg <= shift_reg << 8;       // Shift left by 8 bits
				2'b10: shift_reg <= shift_reg >>> 1;      // Shift right by 1 bit (arithmetic)
				2'b11: shift_reg <= shift_reg >>> 8;      // Shift right by 8 bits (arithmetic)
			endcase
		end
	end
	
	// Assign the output
	assign q = shift_reg;

endmodule
