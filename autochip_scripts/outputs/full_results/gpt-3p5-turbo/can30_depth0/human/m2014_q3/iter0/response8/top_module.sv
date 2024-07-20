module top_module (
	input [4:1] x,
	output logic f
);

always_comb begin
	case (x)
		4'b0000, 4'b0100, 4'b0111, 4'b1100:
			f = 0;
		4'b0101, 4'b1001:
			f = 1;
		default:
			f = ?; // Choose whatever value is convenient for don't-care inputs
	endcase
end

endmodule
