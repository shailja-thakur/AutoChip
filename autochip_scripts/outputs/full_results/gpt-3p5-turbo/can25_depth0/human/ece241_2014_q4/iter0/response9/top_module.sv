module top_module (
	input clk,
	input x,
	output z
);

reg x_dff;
reg x_dff_not;
reg x_dff_complement;

assign z = x_dff ^ (~x_dff) & (~x_dff_not) | (~x_dff_complement);

always @(posedge clk) begin
   x_dff <= x;
   x_dff_not <= ~x_dff;
   x_dff_complement <= ~x_dff_not;
end

endmodule
