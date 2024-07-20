module top_module (
	input [4:1] x,
	output logic f
);

always_comb begin
	case (x)
		4'b0010, 4'b0011, 4'b0111, 4'b1011, 4'b1110:
			f = 1;
		4'b0110, 4'b1100:
			f = 0;
		default:
			f = 'x;
	endcase
end

endmodule
