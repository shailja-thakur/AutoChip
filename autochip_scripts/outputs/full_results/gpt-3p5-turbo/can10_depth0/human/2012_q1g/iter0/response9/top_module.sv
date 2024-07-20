module top_module (
	input [4:1] x,
	output reg f
);
	always_comb begin
		case(x)
			4'b0000: f = 1;
			4'b0001: f = 0;
			4'b0011: f = 1;
			4'b0010: f = 1;
			4'b0110: f = 1;
			4'b0111: f = 0;
			4'b1111: f = 1;
			4'b1110: f = 0;
			4'b1010: f = 1;
			default: f = 0; // default case
		endcase
	end
endmodule
