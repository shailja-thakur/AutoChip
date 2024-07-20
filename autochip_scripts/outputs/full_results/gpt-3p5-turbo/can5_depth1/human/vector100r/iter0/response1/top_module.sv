module top_module (
	input [99:0] in,
	output reg [99:0] out
);

// Declare a temporary variable to hold the reversed bit vector
reg [99:0] reversed_vector;

// Assign the reversed value to the temporary variable
always @(*)
begin
	for (int i = 0; i < 100; i=i+1)
	begin
		reversed_vector[i] = in[99-i];
	end
end

// Assign the temporary variable to the output
always @(posedge clk)
begin
	out <= reversed_vector;
end

endmodule
