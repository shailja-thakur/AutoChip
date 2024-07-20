module top_module (
	input [4:1] x,
	output logic f
);

always_latch: always_comb begin
	case (x)
		4'b00?? : f = 1'b1;
		4'b010? : f = 1'b0;
		4'b0111 : f = 1'b1;
		4'b10?? : f = 1'b0;
		default : f = 1'bx; // Don't care condition
	endcase
end

endmodule
