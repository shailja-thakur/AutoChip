module top_module (
	input clk,
	input in,
	output logic out
);

logic xor_output;
logic q;

always_ff @(posedge clk) begin
	q <= xor_output;
end

assign xor_output = in ^ q;
assign out = q;

endmodule
