module top_module (
	input [99:0] in,
	output reg [99:0] out
);

// Combinational logic to reverse the order of bits in the input
always_comb begin
	for (integer i = 0; i < $bits(out); i = i + 1) begin
		out[i] = in[$bits(out) - i - 1];
	end
end

endmodule
