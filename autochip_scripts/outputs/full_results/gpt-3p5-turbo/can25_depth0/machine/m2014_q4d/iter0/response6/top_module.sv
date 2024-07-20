module top_module (
	input clk,
	input in,
	output logic out
);

always_ff @(posedge clk) begin
	if (in)
		out <= ~out; // toggle the output signal
end

endmodule
