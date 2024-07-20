module top_module (
	input [254:0] in,
	output reg [7:0] out
);

always_comb begin
	out = 0; // initialize the output signal to 0
	for (int i = 0; i < 255; i = i + 1) begin // iterate through all bits of the input signal
		out = out + in[i]; // increment the output signal by the corresponding bit in the input signal
	end
end

endmodule
