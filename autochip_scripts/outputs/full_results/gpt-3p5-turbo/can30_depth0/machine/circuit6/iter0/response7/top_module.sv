module top_module (
	input [2:0] a, 
	output reg [15:0] q
);
	always @(a)
		case (a)
			3'b000: q <= 16'h1232;
			3'b001: q <= 16'haf90;
			3'b010: q <= 16'h27c4;
			3'b011: q <= 16'h59f6;
			3'b100: q <= 16'h205a;
			3'b101: q <= 16'h641e;
			3'b110: q <= 16'hc516;
			3'b111: q <= 16'h2ef9;
		endcase
endmodule
