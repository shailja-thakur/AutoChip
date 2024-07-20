module top_module(
	input clk,
	input load,
	input [1:0] ena,
	input [99:0] data,
	output reg [99:0] q);

	// Define internal signals
	reg [99:0] shift_reg;
	
	// Load logic
	always @(posedge clk) begin
		if (load) begin
			shift_reg <= data;  // Load shift register with data
		end else if (ena[0]) begin
			if (ena[1]) begin
				shift_reg <= {shift_reg[0], shift_reg[99:1]};  // Rotate left by one bit
			end else begin
				shift_reg <= {shift_reg[98:0], shift_reg[99]};  // Rotate right by one bit
			end
		end
	end
	
	// Output logic
	assign q = shift_reg;
	
endmodule
