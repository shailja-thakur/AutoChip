module top_module (
	input [7:0] a,
	input [7:0] b,
	input [7:0] c,
	input [7:0] d,
	output reg [7:0] min
);

// Compare 'a' and 'b', and assign the smaller value to 'min'
always @*
begin
	if (a < b)
		min = a;
	else
		min = b;
end

// Compare 'min' with 'c', and assign the smaller value to 'min'
always @*
begin
	if (min < c)
		min = min;
	else
		min = c;
end

// Compare 'min' with 'd', and assign the smaller value to 'min'
always @*
begin
	if (min < d)
		min = min;
	else
		min = d;
end

endmodule
