module top_module (
	input clk,
	input in,
	output logic out
);
reg d;

always @(posedge clk) begin
	d <= in ^ out;
	out <= d;
end

endmodule
