module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

	// Counting logic
	always @(posedge clk) begin
		if (reset) 
			q <= 4'd0;            // When reset is high, set counter to 0
		else 
			if (q == 4'd9) 
				q <= 4'd0;        // If q is 9, reset counter to 0
			else 
				q <= q + 1;       // Else, increment the counter
	end

endmodule
