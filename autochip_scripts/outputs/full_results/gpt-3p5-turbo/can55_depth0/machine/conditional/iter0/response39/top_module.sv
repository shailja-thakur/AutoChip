module top_module (
	input [7:0] a,
	input [7:0] b,
	input [7:0] c,
	input [7:0] d,
	output reg [7:0] min
);
	always_comb begin
		min = a; // Assign the value of a to min
		
		if (b < min) begin // Compare b with min
			min = b;
		end
		
		if (c < min) begin // Compare c with min
			min = c;
		end
		
		if (d < min) begin // Compare d with min
			min = d;
		end
	end
endmodule
