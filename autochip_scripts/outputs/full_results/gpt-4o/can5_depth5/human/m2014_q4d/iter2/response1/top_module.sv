module top_module (
	input clk,
	input in,
	output logic out
);

logic xor_output;
logic dff_q;

always_ff @(posedge clk) begin
	dff_q <= xor_output;
end

assign xor_output = in ^ dff_q;
assign out = dff_q;

endmodule
