module top_module (
	input [4:1] x,
	output logic f
);

always_comb begin
	case (x)
		4'b00xx: f = 0;
		4'b01x1: f = 0;
		4'b01x0: f = 1;
		4'b11x1: f = 1;
		4'b111x: f = 1;
		4'b10x0: f = 0;
		default: f = 0;
	endcase
end

endmodule
