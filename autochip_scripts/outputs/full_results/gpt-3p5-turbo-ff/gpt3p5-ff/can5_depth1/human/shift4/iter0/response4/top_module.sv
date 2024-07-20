module top_module(
	input clk,
	input areset,
	input load,
	input ena,
	input [3:0] data,
	output reg [3:0] q);

	// internal signal declarations
	reg [3:0] shift_reg;

	// reset logic
	always @(posedge clk or posedge areset)
	begin
		if (areset)
			shift_reg <= 4'b0000;
		else if (load)
			shift_reg <= data;
		else if (ena)
			shift_reg <= {1'b0, shift_reg[3:1]};
	end
	
	// output assignment
	assign q = shift_reg;
	
endmodule
