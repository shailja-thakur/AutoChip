module top_module (
	input [4:1] x,
	output logic f
);

always_comb begin
	case (x)
		4'b0000: f = x;
		4'b0001: f = 1'b0;
		4'b001x: f = 1'b1;
		4'b010x: f = 1'b0;
		4'b0110: f = 1'b1;
		4'b1100: f = 1'b1;
		4'b1101: f = 1'b1;
		default: f = 1'bx;
	endcase
end

endmodule
