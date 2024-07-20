module top_module (
	input [4:1] x,
	output logic f
);

always_comb begin
	case (x)
		4'b0000, 4'b0101, 4'b1001, 4'b1101, 4'b1110:
			f <= 0;
		4'b0010, 4'b0111:
			f <= 1;
		4'b0011, 4'b0110:
			f <= x[2];
		4'b1000:
			f <= x[3];
		default:
			f <= 0;
	endcase
end

endmodule
