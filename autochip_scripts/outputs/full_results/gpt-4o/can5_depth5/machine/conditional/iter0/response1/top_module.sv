module top_module (
	input [7:0] a,
	input [7:0] b,
	input [7:0] c,
	input [7:0] d,
	output reg [7:0] min
);

	always @(*) begin
		min = a; // Assign a to min initially
		if (b < min) begin
			min = b; // Update min if b is smaller
		end
		if (c < min) begin
			min = c; // Update min if c is smaller
		end
		if (d < min) begin
			min = d; // Update min if d is smaller
		end
	end
	
endmodule
