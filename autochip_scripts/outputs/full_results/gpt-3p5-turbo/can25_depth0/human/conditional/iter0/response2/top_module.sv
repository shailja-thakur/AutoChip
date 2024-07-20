module top_module (
	input [7:0] a,
	input [7:0] b,
	input [7:0] c,
	input [7:0] d,
	output reg [7:0] min
);

always @(*) begin
	// Initialize min with the maximum possible value
	min = 8'hFF;
	
	// Compare a with min and update min if a is smaller
	if(a < min)
		min = a;
	
	// Compare b with min and update min if b is smaller
	if(b < min)
		min = b;
	
	// Compare c with min and update min if c is smaller
	if(c < min)
		min = c;
	
	// Compare d with min and update min if d is smaller
	if(d < min)
		min = d;
end

endmodule
