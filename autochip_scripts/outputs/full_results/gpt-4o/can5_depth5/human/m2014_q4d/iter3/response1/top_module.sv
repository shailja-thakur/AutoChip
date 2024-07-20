module top_module (
	input clk,
	input in,
	output logic out
);

logic out_ff;

always_ff @(posedge clk) begin
	out_ff <= in ^ out_ff;
end

assign out = out_ff;

endmodule
