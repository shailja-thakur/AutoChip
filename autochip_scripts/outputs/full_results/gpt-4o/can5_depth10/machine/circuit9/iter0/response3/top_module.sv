module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);
	initial
		q = 3'b000;

	always @(posedge clk) begin
		if (a) begin
			q <= 3'b100;
		end else begin
			if (q == 3'b110) begin
				q <= 3'b000;
			end else begin
				q <= q + 3'b001;
			end
		end
	end
endmodule
