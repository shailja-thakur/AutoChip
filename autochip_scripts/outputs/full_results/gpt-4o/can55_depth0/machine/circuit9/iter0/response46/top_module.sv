module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

	always @(posedge clk) begin
		if (a) begin
			q <= 3'b100;  // When a is 1, q is set to 4
		end else begin
			if (q == 3'b110) begin  // When a is 0 and q is 6, q is set to 0
				q <= 3'b000;
			end else begin  // When a is 0 and q is not 6, q is increased by 1
				q <= q + 3'b001;
			end
		end
	end

endmodule
