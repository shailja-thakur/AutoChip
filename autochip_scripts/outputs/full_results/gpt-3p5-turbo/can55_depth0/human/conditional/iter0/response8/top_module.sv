module top_module (
	input [7:0] a,
	input [7:0] b,
	input [7:0] c,
	input [7:0] d,
	output [7:0] min
);

always @ (*) begin
	min = a;  // Assume 'a' is the minimum

	if (b < min) begin
		min = b;  // Update minimum if 'b' is smaller than current minimum
	end

	if (c < min) begin
		min = c;  // Update minimum if 'c' is smaller than current minimum
	end

	if (d < min) begin
		min = d;  // Update minimum if 'd' is smaller than current minimum
	end
end

endmodule
