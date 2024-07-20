module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);
	always @* begin
		if (c[0] == 0) begin
			q = b[0];
		end else if (c[0] == 1) begin
			q = e[0];
		end else if (c[0] == 2) begin
			q = a[0];
		end else if (c[0] == 3) begin
			q = d[0];
		end else if (c[0] == 4) begin
			q = f[0];
		end else if (c[0] == 5) begin
			q = f[0];
		end else if (c[0] == 6) begin
			q = f[0];
		end else if (c[0] == 7) begin
			q = f[0];
		end else if (c[0] == 8) begin
			q = f[0];
		end else if (c[0] == 9) begin
			q = f[0];
		end else if (c[0] == 10) begin
			q = f[0];
		end else if (c[0] == 11) begin
			q = f[0];
		end else if (c[0] == 12) begin
			q = f[0];
		end else if (c[0] == 13) begin
			q = f[0];
		end else if (c[0] == 14) begin
			q = f[0];
		end else if (c[0] == 15) begin
			q = f[0];
		end
	end
endmodule
