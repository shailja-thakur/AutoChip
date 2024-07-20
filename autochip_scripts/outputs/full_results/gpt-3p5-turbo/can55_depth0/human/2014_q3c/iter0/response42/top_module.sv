module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

	reg [2:0] Y;

	always @(posedge clk) begin
		case ({y, x})
			3'b000, 1'b0: Y <= 3'b000;
			3'b000, 1'b1: Y <= 3'b001;
			3'b001, 1'b0: Y <= 3'b001;
			3'b001, 1'b1: Y <= 3'b100;
			3'b010, 1'b0: Y <= 3'b010;
			3'b010, 1'b1: Y <= 3'b001;
			3'b011, 1'b0: Y <= 3'b001;
			3'b011, 1'b1: Y <= 3'b010;
			3'b100, 1'b0: Y <= 3'b011;
			3'b100, 1'b1: Y <= 3'b100;
			default: Y <= 3'b000;
		endcase

		Y0 <= Y[0];
		z <= (Y == 3'b011) || (Y == 3'b100);
	end

endmodule
