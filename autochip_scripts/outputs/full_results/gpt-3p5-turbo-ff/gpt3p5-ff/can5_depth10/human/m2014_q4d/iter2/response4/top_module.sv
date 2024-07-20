module top_module (
	input clk,
	input in,
	output logic out
);
reg d;
reg delayed_out;

always @(posedge clk) begin
	d <= in ^ delayed_out;
end

always @(posedge clk) begin
	delayed_out <= d;
	out <= delayed_out;
end

endmodule
