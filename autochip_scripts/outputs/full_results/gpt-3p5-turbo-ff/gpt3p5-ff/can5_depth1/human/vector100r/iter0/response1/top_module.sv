module top_module (
	input [99:0] in,
	output reg [99:0] out
);

// Create a temporary vector to store the reversed bits
reg [99:0] temp;

// Reverse the bit ordering
integer i;
always @* begin
	for (i = 0; i < 100; i = i + 1) begin
		temp[i] = in[99 - i];
	end
end

// Assign the reversed vector to the output
assign out = temp;

endmodule
