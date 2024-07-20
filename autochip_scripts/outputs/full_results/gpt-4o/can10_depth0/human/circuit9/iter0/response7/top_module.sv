module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

	always @(posedge clk) begin
		if (a == 1'b1) begin
			q <= 3'b100;  // When 'a' is 1, set q to 4 (in binary: 100).
		end else begin
			if (q == 3'b111 || q == 3'b011 || q == 3'b010) begin
				q <= 3'b000;  // Reset q to 0 if it's 3'b111 (7), 3'b011 (3), or 3'b010 (2)
			} else begin
				q <= q + 1;  // Increment q otherwise.
			}
		end
	end

endmodule
