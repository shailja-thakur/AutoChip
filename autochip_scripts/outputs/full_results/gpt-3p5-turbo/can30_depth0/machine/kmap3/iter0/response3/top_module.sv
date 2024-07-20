module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

always @* begin
	if (a == 0 && b == 0 && c == 0 && d == 0) begin
		out = 0;
	end else if (a == 0 && b == 0 && c == 0 && d == 1) begin
		out = 0;
	end else if (a == 0 && b == 0 && c == 0 && d == 3) begin
		out = 1;
	end else if (a == 0 && b == 0 && c == 0 && d == 2) begin
		out = 1;
	end else if (a == 0 && b == 0 && c == 0 && d == 4) begin
		out = 1'bx;
	end else if (a == 0 && b == 0 && c == 0 && d == 5) begin
		out = 0;
	end else if (a == 0 && b == 0 && c == 0 && d == 7) begin
		out = 0;
	end else if (a == 0 && b == 0 && c == 0 && d == 6) begin
		out = 0;
	end else if (a == 0 && b == 0 && c == 0 && d == c) begin
		out = 1;
	end else if (a == 0 && b == 0 && c == 0 && d == d) begin
		out = 1'bx;
	end else if (a == 0 && b == 0 && c == 0 && d == f) begin
		out = 1;
	end else if (a == 0 && b == 0 && c == 0 && d == e) begin
		out = 1;
	end else if (a == 0 && b == 0 && c == 0 && d == 8) begin
		out = 1;
	end else if (a == 0 && b == 0 && c == 0 && d == 9) begin
		out = 1'bx;
	end else if (a == 0 && b == 0 && c == 0 && d == b) begin
		out = 1;
	end else if (a == 0 && b == 0 && c == 0 && d == a) begin
		out = 1;
	end else begin
		out = 1'bx; // Default output
	end
end

endmodule
