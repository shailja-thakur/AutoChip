module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

always @(a, b, c, d) begin
	if (c == 0 && d == 0)
		out = 1;
	else if (c == 0 && d == 1)
		out = 1;
	else if (c == 1 && d == 0)
		out = 0;
	else if (c == 1 && d == 1)
		out = 1;
	else
		out = 0; // Default case for don't-care values
end

endmodule
