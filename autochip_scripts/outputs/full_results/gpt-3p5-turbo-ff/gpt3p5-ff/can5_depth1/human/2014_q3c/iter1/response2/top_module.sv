module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

	reg [2:0] Y;
	always @(posedge clk) begin
		case ({x, y})
			3'b000: Y <= 3'b000;
			3'b001: Y <= x ? 3'b100 : 3'b001;
			3'b010: Y <= 3'b001;
			3'b011: Y <= 3'b001;
			3'b100: Y <= 3'b011;
			default: Y <= 3'b000;
		endcase
	end

	assign Y0 = Y[0];
	assign z = (y == 3'b011) ? 1'b1 : 1'b0;

endmodule
