module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

reg [99:0] in_reg;
wire [99:0] in_wire = in_reg;

assign out_and = &in_wire;
assign out_or = |in_wire;
assign out_xor = ^in_wire;

always @(*) begin
	in_reg = in;
end

endmodule
