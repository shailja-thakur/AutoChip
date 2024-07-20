module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);
	initial begin
		q = 3'bxxx; // undefined initial state
	end

	always @(posedge clk) begin
		if (a) begin
			q <= 3'b100;  // When `a` is 1, `q` remains 4
		end else begin
			q <= q + 1; // When `a` is 0, `q` increments by 1
			if (q == 3'b110) // Reset `q` to 0 after it reaches 6
				q <= 3'b000;
		end
	end
endmodule
