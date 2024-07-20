module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

	always @(posedge clk) begin
		if (a == 1'b1) begin
			q <= 3'b100; // q is set to 4
		end else begin
			if (q == 3'b110) begin
				q <= 3'b000; // q is set to 0 if it was 6
			end else begin
				q <= q + 3'b001; // q is increased by 1
			end
		end
	end

endmodule
