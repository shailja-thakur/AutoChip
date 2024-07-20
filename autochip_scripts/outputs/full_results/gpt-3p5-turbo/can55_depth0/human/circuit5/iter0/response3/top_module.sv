module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);
	always @* begin
		if (a == 4'b0000 && b == 4'b0000 && c == 4'b0000 && d == 4'b0000 && e == 4'b0000) begin
			q <= 4'b0000;
		end else if (a == b && c == 4'b0000 && d == e && q != 4'b1111) begin
			q <= b;
		end else if (c == 4'b0001) begin
			q <= e;
		end else if (c == 4'b0010) begin
			q <= a;
		end else if (c == 4'b0011) begin
			q <= d;
		end else if (c == 4'b0100 || c == 4'b0101 || c == 4'b0110 || c == 4'b0111) begin
			q <= 4'b1111;
		end else begin
			q <= f;
		end
	end
endmodule
