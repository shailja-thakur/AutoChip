module top_module (
	input [99:0] in,
	output reg [99:0] out
);

	always @* begin
		integer i;
		for (i = 0; i < 100; i = i + 1) begin
			out[i] = in[99 - i];
		end
	end

endmodule
