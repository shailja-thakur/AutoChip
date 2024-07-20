module top_module(
	output reg zero);

// Assigning constant value 0 to the output
always @(posedge clk) begin
	zero <= 0;
end

endmodule
