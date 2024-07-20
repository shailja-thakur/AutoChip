module top_module (
	input [7:0] a,
	input [7:0] b,
	input [7:0] c,
	input [7:0] d,
	output reg [7:0] min
);

// Declare a temporary variable to store the minimum value
reg [7:0] temp;

always @* begin
	// Compare a with b
	if(a < b)
		temp = a;
	else
		temp = b;
	
	// Compare temp with c
	if(temp < c)
		temp = temp;
	else
		temp = c;
	
	// Compare temp with d
	if(temp < d)
		min = temp;
	else
		min = d;
end

endmodule
