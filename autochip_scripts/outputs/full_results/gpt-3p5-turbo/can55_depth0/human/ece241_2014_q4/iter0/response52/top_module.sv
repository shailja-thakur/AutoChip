module top_module (
	input clk,
	input x,
	output z
);

reg d_ff_0;
reg d_ff_1;
reg d_ff_2;
wire xor_out;
wire and_out;
wire or_out;

assign z = ~(xor_out ^ and_out ^ or_out);

always @(posedge clk) begin
	if (x) begin
		d_ff_0 <= ~d_ff_0;
		d_ff_1 <= ~d_ff_1;
		d_ff_2 <= ~d_ff_2;
	end
end

assign xor_out = x ^ d_ff_0;
assign and_out = x & ~d_ff_1;
assign or_out = x | ~d_ff_2;

endmodule
