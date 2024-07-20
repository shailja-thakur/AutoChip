module top_module (
	input clk,
	input d,
	input ar,
	output logic q
);

// D flip flop positive edge triggered
always @(posedge clk) begin
	if (ar) begin
		q <= 0;
	end else begin
		q <= d;
	end
end

endmodule
