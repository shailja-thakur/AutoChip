module top_module (
	input [4:1] x,
	output logic f
);

always_comb begin
	case (x)
		4'b00??: f = 0;  // d = 0
		4'b(01)0: f = 0;
		4'b01??: f = 1;  // d = 1
		4'b(10)0: f = 0;
		4'b10??: f = 1;  // d = 1
		4'b(11)?: f = 1;
		default: f = 0;  // don't care
	endcase
end

endmodule
