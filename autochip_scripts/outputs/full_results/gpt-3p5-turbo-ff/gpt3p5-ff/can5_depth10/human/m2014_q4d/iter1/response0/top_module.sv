module top_module (
	input clk,
	input in,
	output logic out
);

logic d;
reg prev_out;

always @(posedge clk) begin
	d <= in ^ prev_out;
	prev_out <= d;
end

assign out = prev_out;

endmodule
