module top_module (
	input clk,
	input in,
	output logic out
);

logic q;

always_ff @(posedge clk) begin
	q <= in ^ out;
end

assign out = q;

endmodule
