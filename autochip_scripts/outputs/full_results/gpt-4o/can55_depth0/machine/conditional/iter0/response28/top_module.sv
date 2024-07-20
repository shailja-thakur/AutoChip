module top_module (
	input [7:0] a,
	input [7:0] b,
	input [7:0] c,
	input [7:0] d,
	output reg [7:0] min
);
  
	always @(*) begin
		min = a; // Start by assuming a is the minimum
		
		if (b < min) begin
			min = b; // Update to b if b is lesser
		end
		if (c < min) begin
			min = c; // Update to c if c is lesser
		end
		if (d < min) begin
			min = d; // Update to d if d is lesser
		end
	end

endmodule
