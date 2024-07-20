module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);

	always @(*) begin
		case ({a,b,c,d,e})
			4'b0000: q <= b;
			4'b0001: q <= e;
			4'b0010: q <= a;
			4'b0011: q <= d;
			4'b0100: q <= 'b1111;
			4'b0101: q <= 'b1111;
			4'b0110: q <= 'b1111;
			4'b0111: q <= 'b1111;
			4'b1000: q <= 'b1111;
			4'b1001: q <= 'b1111;
			4'b1010: q <= 'b1111;
			4'b1011: q <= 'b1111;
			4'b1100: q <= 'b1111;
			4'b1101: q <= 'b1111;
			4'b1110: q <= 'b1111;
			4'b1111: q <= 'b1111;
		endcase
	end

endmodule
