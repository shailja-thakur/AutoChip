module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Logic for out_both
	assign out_both[0] = in[0] & in[99];
	for (int i = 1; i < 99; i = i + 1) begin
		assign out_both[i] = in[i] & in[i-1];
	end
	
	// Logic for out_any
	assign out_any[1] = in[1] | in[0];
	for (int i = 2; i < 100; i = i + 1) begin
		assign out_any[i] = in[i] | in[i-1];
	end

	// Logic for out_different
	assign out_different[0] = in[0] ^ in[99];
	for (int i = 1; i < 100; i = i + 1) begin
		assign out_different[i] = in[i] ^ in[i-1];
	end

endmodule
