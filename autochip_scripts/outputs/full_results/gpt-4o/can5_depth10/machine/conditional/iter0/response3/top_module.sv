module top_module (
	input [7:0] a,
	input [7:0] b,
	input [7:0] c,
	input [7:0] d,
	output reg [7:0] min
);

	always @(*) begin
		// Initialize min with the value of a
		min = a;
		// Compare with b
		if (b < min) begin
			min = b;
		end
		// Compare with c
		if (c < min) begin
			min = c;
		end
		// Compare with d
		if (d < min) begin
			min = d;
		end
	end
	
endmodule
