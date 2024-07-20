module top_module (
	input [4:1] x,
	output logic f
);

always_comb begin
	case(x)
		4'b0001: f = 1'b0;
		4'b0011: f = 1'b0;
		4'b0110: f = 1'b0;
		4'b1110: f = 1'b0;
		default: f = 1'b1;
	endcase
end

endmodule
