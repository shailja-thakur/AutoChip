module top_module (
	input [4:1] x,
	output logic f
);
		
	always_comb begin
		case (x)
			4'b0000, 4'b0100: f = 1;
			4'b0001: f = 0;
			4'b0010, 4'b0110, 4'b0111, 4'b1010: f = 1;
			4'b0011: f = 1;
			4'b1000: f = 0;
			default: f = 0;
		endcase
	end
endmodule
