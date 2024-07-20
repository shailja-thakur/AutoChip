module top_module (
	input [4:1] x,
	output logic f
);

always_comb begin
	case (x)
		4'b00??: f = 0;
		4'b01??: f = 0;
		4'b11??: f = 1;
		default:  f = 1;
	endcase
end

endmodule
