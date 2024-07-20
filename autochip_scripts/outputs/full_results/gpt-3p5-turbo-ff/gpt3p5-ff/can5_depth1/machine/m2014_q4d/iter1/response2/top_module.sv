module top_module (
	input clk,
	input in,
	output logic out
);

reg out_reg;

always @(posedge clk) begin
    out_reg <= in ^ out_reg;
end

always @(posedge clk) begin
    out <= out_reg;
end

endmodule
