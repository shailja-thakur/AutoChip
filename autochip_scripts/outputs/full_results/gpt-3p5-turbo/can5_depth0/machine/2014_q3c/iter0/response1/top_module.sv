module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

	always_comb begin
		case ({y[2:0],x})
			4'b0000: Y0 = 1'b0;
			4'b0001: Y0 = 1'b1;
			4'b0010: Y0 = 1'b1;
			4'b0011: Y0 = 1'b0;
			4'b0100: Y0 = 1'b0;
			4'b0101: Y0 = 1'b1;
			4'b0110: Y0 = 1'b1;
			4'b0111: Y0 = 1'b0;
			4'b1000: Y0 = 1'b1;
			4'b1001: Y0 = 1'b0;
			default: Y0 = x;
		endcase

		case (y[2:0])
			3'b000: z = 1'b0;
			3'b001: z = 1'b0;
			3'b010: z = 1'b0;
			3'b011: z = 1'b1;
			3'b100: z = 1'b1;
			default: z = x;
		endcase
	end

endmodule
