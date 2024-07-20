module top_module (
	input [4:1] x,
	output logic f
);
	
	always_comb begin
		case (x[3:0])
			4'bxxxx: f = 0; // in case of all don't cares, output 0
			4'b00xx: f = 1; // in case of x[3]=0, x[4]=0
			4'b01xx: f = 0; // in case of x[3]=0, x[4]=1
			4'b11xx: f = 1; // in case of x[3]=1, x[4]=1
			4'b10xx: f = 1; // in case of x[3]=1, x[4]=0
			default: f = 0; // default output
		endcase
	end
	
endmodule
