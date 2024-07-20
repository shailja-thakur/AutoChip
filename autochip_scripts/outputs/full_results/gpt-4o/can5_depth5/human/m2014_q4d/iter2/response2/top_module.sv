module top_module (
	input clk,
	input in,
	output logic out
);

logic xor_output;
logic out_next;

always_ff @(posedge clk) begin
	out <= out_next;
end

always_comb begin
	out_next = in ^ out;
end

endmodule
