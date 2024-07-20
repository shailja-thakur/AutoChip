module top_module (
	input clk,
	input d,
	input r,
	output logic q
);

// Synchronous reset flip flop with active high reset
always_ff @(posedge clk, posedge r) begin
	if (r) begin
		q <= 0;
	end else begin
		q <= d;
	end
end

endmodule
