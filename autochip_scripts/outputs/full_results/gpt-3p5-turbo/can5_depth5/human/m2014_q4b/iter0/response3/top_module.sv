module top_module (
	input clk,
	input d,
	input ar,
	output logic q
);

// D flip flop positive edge triggered with asynchronous reset

always @(posedge clk or negedge ar) begin
	if (ar == 0) begin
		q <= 0;
	end else begin
		q <= d;
	end
end

endmodule
