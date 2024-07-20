module top_module (
    input [4:1] x,
    output logic f
);
	
	always_comb begin
		case (x)
			4'b00xx: f = 0;   // x[1]=0, x[2]=0
			4'b01xx: f = 0;   // x[1]=0, x[2]=1
			4'b10xx: f = 1;   // x[1]=1, x[2]=0
			4'b11xx: f = 1;   // x[1]=1, x[2]=1
			default: f = 0;   // for don't care cases
		endcase
	end
	
endmodule
