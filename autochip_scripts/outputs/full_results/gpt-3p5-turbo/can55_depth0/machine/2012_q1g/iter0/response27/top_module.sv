module top_module (
	input [4:0] x,
	output logic f
);

	always_comb begin
		case(x)
			5'b0000: f = 1;
			5'b0001: f = 1;
			5'b0010: f = 0;
			5'b0011: f = 0;
			5'b0100: f = 1;
			5'b0101: f = 1;
			5'b0110: f = 1;
			5'b0111: f = 0;
			5'b1000: f = 0;
			5'b1001: f = 0;
			5'b1010: f = 0;
			5'b1011: f = 0;
			5'b1100: f = 1;
			5'b1101: f = 0;
			5'b1110: f = 1;
			5'b1111: f = 1;
			default: f = 0; // Handle any other value
		endcase
	end
	
endmodule
