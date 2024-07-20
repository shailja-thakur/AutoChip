module top_module (
	input clk,
	input x,
	input [2:0] y,
	output reg Y0,
	output reg z
);

	always_comb begin
		case (y[2:0])
			3'b000: Y0 = 0;
			3'b001: Y0 = 1;
			3'b010: Y0 = 1;
			3'b011: Y0 = 0;
			default: Y0 = x;
		endcase

		case (y[2:0])
			3'b000: z = 0;
			3'b001: z = 0;
			3'b010: z = 0;
			3'b011: z = 1;
			default: z = x;
		endcase
	end

endmodule
