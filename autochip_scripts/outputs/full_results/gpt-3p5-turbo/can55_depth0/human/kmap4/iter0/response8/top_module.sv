module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);
	always @* begin
		if (a == 0 && b == 0 && c == 0 && d == 0)
			out = 0;
		else if (a == 0 && b == 0 && c == 0 && d == 1)
			out = 1;
		else if (a == 0 && b == 0 && c == 1 && d == 0)
			out = 0;
		else if (a == 0 && b == 0 && c == 1 && d == 1)
			out = 1;
		else if (a == 0 && b == 1 && c == 0 && d == 0)
			out = 1;
		else if (a == 0 && b == 1 && c == 0 && d == 1)
			out = 0;
		else if (a == 0 && b == 1 && c == 1 && d == 0)
			out = 1;
		else if (a == 0 && b == 1 && c == 1 && d == 1)
			out = 0;
		else if (a == 1 && b == 0 && c == 0 && d == 0)
			out = 0;
		else if (a == 1 && b == 0 && c == 0 && d == 1)
			out = 1;
		else if (a == 1 && b == 0 && c == 1 && d == 0)
			out = 0;
		else if (a == 1 && b == 0 && c == 1 && d == 1)
			out = 1;
		else if (a == 1 && b == 1 && c == 0 && d == 0)
			out = 1;
		else if (a == 1 && b == 1 && c == 0 && d == 1)
			out = 0;
		else if (a == 1 && b == 1 && c == 1 && d == 0)
			out = 1;
		else
			out = 0;
	end
endmodule
