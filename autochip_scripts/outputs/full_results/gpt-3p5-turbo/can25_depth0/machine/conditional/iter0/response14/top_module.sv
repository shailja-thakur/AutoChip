module top_module (
	input [7:0] a,
	input [7:0] b,
	input [7:0] c,
	input [7:0] d,
	output reg [7:0] min
);

	always_comb begin
		min = a; // assign the initial value of a to min
		
		if (b < min) begin
			min = b; // update min if b is less than min
		end
		
		if (c < min) begin
			min = c; // update min if c is less than min
		end
		
		if (d < min) begin
			min = d; // update min if d is less than min
		end
	end
	
endmodule
