module top_module(
	input clk,
	input areset,
	input load,
	input ena,
	input [3:0] data,
	output reg [3:0] q);

	// Define internal signals for the module
	reg [3:0] shift_reg;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			shift_reg <= 4'b0000;
		end else if (load) begin
			shift_reg <= data;
		end else if (ena) begin
			shift_reg <= {1'b0, shift_reg[3:1]};
		end
	end
	
	assign q = shift_reg;
	
endmodule
