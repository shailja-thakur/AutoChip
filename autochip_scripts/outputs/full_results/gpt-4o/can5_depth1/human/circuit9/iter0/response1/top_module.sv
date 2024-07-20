module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

	always @(posedge clk) begin
		if (a) begin
			// If a is high, set q to 4
			q <= 3'b100;
		end else begin
			// If a is low, increment q
			if (q == 3'b110) begin
				// If q reaches 6, reset q to 0
				q <= 3'b000;
			} else begin
				q <= q + 1;
			}
		end
	end

endmodule
