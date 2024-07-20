module top_module (
	input clk,
	input resetn,
	input in,
	output reg out
);

	// Internal register to hold the state of the 4-bit shift register
	reg [3:0] shift_reg;
	
	always @(posedge clk) begin
		if (!resetn) begin
			shift_reg <= 4'b0000;     // Synchronous reset to 0 when resetn is low
		end else begin
			shift_reg <= {shift_reg[2:0], in};  // Shift left and input new bit 'in'
		end
	end
	
	assign out = shift_reg[3]; // Output is the MSB of the shift register

endmodule
