module top_module (
	input clk,
	input in,
	output logic out
);

logic d;
reg out_reg;

always @(posedge clk) begin
	d <= in ^ out_reg;
	out_reg <= d;
end

assign out = out_reg;

endmodule
