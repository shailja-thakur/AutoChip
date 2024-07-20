module top_module (
	input [254:0] in,
	output reg [7:0] out
);

always_comb begin
	out = 0; // Initialize output signal "out" to 0

	for (int i = 0; i < 255; i=i+1) begin
		out = out + in[i]; // Add each bit of input signal "in" to output signal "out"
	end
end

endmodule
