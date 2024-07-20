module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

	reg [2:0] Y_next;

	always @(posedge clk) begin

		case (y)

			3'b000: Y_next = x ? 3'b001 : 3'b000;
			3'b001: Y_next = x ? 3'b100 : 3'b001;
			3'b010: Y_next = x ? 3'b001 : 3'b010;
			3'b011: Y_next = x ? 3'b010 : 3'b001;
			3'b100: Y_next = x ? 3'b100 : 3'b011; 

		endcase

		Y0 <= Y_next[0];
		z <= (y == 3'b011 || y == 3'b100) ? 1'b1 : 1'b0;

	end

endmodule
