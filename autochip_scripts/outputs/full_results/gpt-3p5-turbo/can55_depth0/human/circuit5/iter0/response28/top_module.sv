module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);
	
	always @* begin
		if (c == 0) begin
			q = b;
		end else if (c == 1) begin
			q = e;
		end else if (c == 2) begin
			q = a;
		end else if (c == 3) begin
			q = d;
		end else if (c == 4) begin
			q = 4'b1111;
		end else if (c == 5) begin
			q = 4'b1111;
		end else if (c == 6) begin
			q = 4'b1111;
		end else if (c == 7) begin
			q = 4'b1111;
		end else if (c == 8) begin
			q = 4'b1111;
		end else if (c == 9) begin
			q = 4'b1111;
		end else if (c == 10) begin
			q = 4'b1111;
		end else if (c == 11) begin
			q = 4'b1111;
		end else if (c == 12) begin
			q = 4'b1111;
		end else if (c == 13) begin
			q = 4'b1111;
		end else if (c == 14) begin
			q = 4'b1111;
		end else if (c == 15) begin
			q = 4'b1111;
		end else begin
			q = 4'b0000;
		end
	end
	
endmodule
