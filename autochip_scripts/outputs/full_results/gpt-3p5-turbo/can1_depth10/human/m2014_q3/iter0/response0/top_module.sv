module top_module (
	input [4:1] x,
	output logic f
);

always_comb begin
	case (x)
		4'b00?? : f = 0;     // when x[1]=0, x[2]=0
		4'b010? : f = 0;     // when x[1]=0, x[2]=1
		4'b011? : f = 1;     // when x[1]=0, x[2]=1
		4'b?11? : f = 1;     // when x[1]=1, x[2]=1
		4'b10?? : f = 1;     // when x[1]=1, x[2]=0
		default: f = 0;      // for all other cases
	endcase
end

endmodule
