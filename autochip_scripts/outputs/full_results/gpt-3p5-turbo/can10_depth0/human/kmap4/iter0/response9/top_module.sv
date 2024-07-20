module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

always @(*) begin
	if (a == 0 && b == 0 && c == 0 && d == 0) begin
		out = 0;
	end else if (a == 0 && b == 0 && c == 0 && d == 1) begin
		out = 1;
	end else if (a == 0 && b == 0 && c == 1 && d == 1) begin
		out = 0;
	end else if (a == 0 && b == 0 && c == 1 && d == 0) begin
		out = 1;
	end else if (a == 0 && b == 1 && c == 0 && d == 0) begin
		out = 1;
	end else if (a == 0 && b == 1 && c == 0 && d == 1) begin
		out = 0;
	end else if (a == 0 && b == 1 && c == 1 && d == 1) begin
		out = 1;
	end else if (a == 0 && b == 1 && c == 1 && d == 0) begin
		out = 0;
	end else if (a == 1 && b == 0 && c == 0 && d == 0) begin
		out = 0;
	end else if (a == 1 && b == 0 && c == 0 && d == 1) begin
		out = 1;
	end else if (a == 1 && b == 0 && c == 1 && d == 1) begin
		out = 0;
	end else if (a == 1 && b == 0 && c == 1 && d == 0) begin
		out = 1;
	end else if (a == 1 && b == 1 && c == 0 && d == 0) begin
		out = 1;
	end else if (a == 1 && b == 1 && c == 0 && d == 1) begin
		out = 0;
	end else if (a == 1 && b == 1 && c == 1 && d == 1) begin
		out = 1;
	end else if (a == 1 && b == 1 && c == 1 && d == 0) begin
		out = 0;
	end
end

endmodule
