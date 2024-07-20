module top_module (
	input clk,
	input in,
	output logic out
);

logic d;

always_comb begin
	d = in ^ out;
end

always_ff @(posedge clk) begin
	out <= d;
end

endmodule
