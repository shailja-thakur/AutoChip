module top_module (
	input clk,
	input x,
	output z
);

reg dff1;
reg dff2;
reg dff3;

wire x_xor_dff1;
wire x_and_dff2;
wire x_or_dff3;

assign z = ~(x_xor_dff1 ^ x_and_dff2 ^ x_or_dff3);

always @(posedge clk) begin
	dff1 <= x_xor_dff1;
	dff2 <= ~x_and_dff2;
	dff3 <= ~x_or_dff3;
end

xor(x_xor_dff1, x, dff1);
and(x_and_dff2, x, dff2);
or(x_or_dff3, x, dff3);

endmodule
