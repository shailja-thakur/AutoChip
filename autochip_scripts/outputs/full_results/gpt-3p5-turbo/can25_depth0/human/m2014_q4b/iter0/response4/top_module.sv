module top_module (
	input clk,
	input d,
	input ar,
	output logic q
);
	
	// D flip flop, positive edge triggered
	always_ff @(posedge clk or negedge ar) begin
		if (!ar) begin
			q <= 0; // asynchronous reset
		end else begin
			q <= d;
		end
	end
	
endmodule
