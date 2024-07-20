module top_module (
	input clk,
	input a,
	output reg [2:0] q
);

	always @(posedge clk) begin
		if (a == 1) begin
			q <= 3'b100; // 4 in binary
		end else begin
			if (q == 3'b110) begin // 6 in binary
				q <= 3'b000; // 0 in binary
			end else begin
				q <= q + 1;
			end
		end
	end

endmodule
