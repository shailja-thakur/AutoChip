module top_module (
	input clk,    // Clock input
	input d,      // Data input
	input ar,     // Asynchronous reset input
	output logic q // Output
);

	always_ff @(posedge clk or negedge ar) begin
		if (!ar) begin
			q <= 0;          // Reset
		end else begin
			q <= d;          // Flip flop
		end
	end
	
endmodule
