module top_module (
	input [254:0] in,
	output reg [7:0] out
);

always_comb begin
	out = 0; // Initialize output signal
	for (int i = 0; i < 255; i = i + 1) begin // Iterate through all bits
		out = out + in[i]; // Increment output by corresponding bit value
	end
end

endmodule
