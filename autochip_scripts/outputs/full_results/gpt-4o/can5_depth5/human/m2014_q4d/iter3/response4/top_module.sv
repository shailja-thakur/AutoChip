module top_module (
	input clk,
	input in,
	output logic out
);

logic xor_output;
logic out_reg;

always_ff @(posedge clk) begin
	out_reg <= xor_output;
end

always_comb begin
	xor_output = in ^ out_reg;
end

assign out = out_reg;

endmodule
