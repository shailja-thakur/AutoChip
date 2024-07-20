module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

	reg [2:0] Y_reg;

	always @(posedge clk) begin
		case ({y,x})
			7'b000_0: Y_reg <= 3'b000;
			7'b000_1: Y_reg <= 3'b001;
			7'b001_0: Y_reg <= 3'b001;
			7'b001_1: Y_reg <= 3'b100;
			7'b010_0: Y_reg <= 3'b010;
			7'b010_1: Y_reg <= 3'b001;
			7'b011_0: Y_reg <= 3'b001;
			7'b011_1: Y_reg <= 3'b010;
			7'b100_0: Y_reg <= 3'b011;
			7'b100_1: Y_reg <= 3'b100;
			default: Y_reg <= 3'b000;
		endcase
	end
	
	// Output assignments
	assign Y0 = Y_reg[0];
	assign z = (Y_reg[2] == 1);
	
endmodule
