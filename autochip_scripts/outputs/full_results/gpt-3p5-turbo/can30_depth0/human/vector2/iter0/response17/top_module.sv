module top_module (
	input [31:0] in,
	output [31:0] out
);

integer i;

always @(*) begin
	for (i = 0; i < 32; i = i + 1) begin
		out[i] = in[31 - i];
	end
end

endmodule
