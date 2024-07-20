module top_module (
	input [4:1] x,
	output logic f
);
	
	always_comb begin
		case(x)
			4'b00-: f = 0;
			4'b0101: f = 1;
			4'b100-: f = x[1];
			default: f = 0;
		endcase
	end
	
endmodule
