module top_module (
	input clk,
	input in,
	output logic out
);

logic xor_output;

always_ff @(posedge clk) begin
	out <= xor_output;
end

always_comb begin
	xor_output = in ^ out;
end

endmodule
