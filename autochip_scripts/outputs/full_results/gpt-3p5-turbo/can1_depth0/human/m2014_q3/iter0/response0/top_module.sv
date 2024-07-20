module top_module (
	input [4:1] x,
	output logic f
);

always_comb begin
	case(x)
		4'b0010, 4'b0011, 4'b1010: f = 0;
		4'b0100: f = 1;
		4'b0110, 4'b0111: f = x[3];
		4'b1100: f = x[1];
		default: f = 1'b0;
	endcase
end

endmodule
