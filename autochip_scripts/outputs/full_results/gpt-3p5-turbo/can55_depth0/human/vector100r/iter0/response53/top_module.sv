module top_module (
	input [99:0] in,
	output reg [99:0] out
);

// Register to hold the reversed bits
reg [99:0] reversed_bits;

// Reverse the bit ordering
integer i;
always @(*) begin
	for (i = 0; i < 100; i = i + 1)
		reversed_bits[i] = in[99 - i];
end

// Assign the reversed bits to the output
assign out = reversed_bits;

endmodule
