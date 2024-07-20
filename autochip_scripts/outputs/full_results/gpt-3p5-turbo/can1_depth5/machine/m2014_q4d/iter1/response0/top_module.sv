module top_module (
	input clk,
	input in,
	output logic out
);

always_ff @(posedge clk) begin
	out <= in ^ out;
end

initial begin
	// Initialize inputs
	clk = 0;
	in = 0;

	// Toggle the clock and input signal
	#5 in = 1;
	#5 in = 0;
	#5 in = 1;

	// Finish simulation
	#1 $finish;
end

endmodule
