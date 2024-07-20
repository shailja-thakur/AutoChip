module top_module (
	input [99:0] in,
	output reg [99:0] out
);

// Create a temporary variable to store the reversed bit vector
reg [99:0] temp;

// Reverse the input bit vector
always @(*) begin
	for (int i = 0; i < 100; i = i + 1) begin
		temp[i] = in[99 - i];
	end
end

// Assign the reversed bit vector to the output signal
always @(*) begin
	out = temp;
end

endmodule
