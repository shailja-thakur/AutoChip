module top_module (
	input [4:1] x,
	output logic f
);

always_comb begin
	case (x)
		4'b00? : f = 0; // 00xx
		4'b01? : f = 1; // 01xx
		4'b11? : f = 1; // 11xx
		4'b10? : f = 0; // 10xx
		default: f = 0; // all other cases
	endcase
end

endmodule
