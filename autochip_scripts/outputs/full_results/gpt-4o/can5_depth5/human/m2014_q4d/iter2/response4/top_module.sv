module top_module (
	input clk,
	input in,
	output logic out
);

logic xor_output;
logic temp_out;

always_ff @(posedge clk) begin
	temp_out <= xor_output;
end

assign xor_output = in ^ temp_out;
assign out = temp_out;

endmodule
