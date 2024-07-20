module top_module(
	input clk,
	input areset,
	input load,
	input ena,
	input [3:0] data,
	output reg [3:0] q);

	// Define internal signals
	reg [3:0] shift_reg;

	always @(posedge clk, posedge areset)
	begin
		// Reset shift register when areset is high
		if (areset)
			shift_reg <= 0;
		// Load data[3:0] into shift register when load is high
		else if (load)
			shift_reg <= data;
		// Shift right if both load and ena are high
		else if (load && ena)
			shift_reg <= {shift_reg[2:0], 1'b0};
		end
	end

	// Assign the output
	assign q = shift_reg;

endmodule
