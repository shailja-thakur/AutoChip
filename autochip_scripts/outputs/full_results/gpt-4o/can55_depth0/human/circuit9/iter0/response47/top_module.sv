module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

	always @(posedge clk) begin
		if (a) begin
			q <= 3'b100;  // Set q to 4 when a is high
		end else begin
			q <= q + 1;  // Otherwise, increment q
			if (q == 3'b100) begin  // Reset q to 0 when it reaches 4
				q <= 3'b000;
			end
		end
	end

endmodule
