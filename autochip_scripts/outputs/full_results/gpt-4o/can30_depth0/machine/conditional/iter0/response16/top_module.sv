module top_module (
	input [7:0] a,
	input [7:0] b,
	input [7:0] c,
	input [7:0] d,
	output reg [7:0] min
);
	always @* begin
		min = a;   // Start by assuming 'a' is the minimum
		
		if (b < min) begin
			min = b;   // Update min if 'b' is smaller than the current min
		end
		
		if (c < min) begin
			min = c;   // Update min if 'c' is smaller than the current min
		end
		
		if (d < min) begin
			min = d;   // Update min if 'd' is smaller than the current min
		end
	end
endmodule
