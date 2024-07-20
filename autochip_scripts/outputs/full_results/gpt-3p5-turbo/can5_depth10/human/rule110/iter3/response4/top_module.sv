module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	reg [511:0] q_reg;
	always @(posedge clk) begin
		if (load) begin
			q_reg <= data;
		end else begin
			q_reg[0] <= (q_reg[1] & q_reg[0]) | (~q_reg[1] & ~q_reg[0]);
			for (int i=1; i<511; i=i+1) begin
				q_reg[i] <= (q_reg[i+1] & (q_reg[i] | ~q_reg[i-1])) | (~q_reg[i+1] & (~q_reg[i-1] | q_reg[i]));
			end
			q_reg[511] <= (q_reg[511-1] & q_reg[511]) | (~q_reg[511-1] & ~q_reg[511]);
		end
	end
	
	assign q = q_reg;

endmodule
