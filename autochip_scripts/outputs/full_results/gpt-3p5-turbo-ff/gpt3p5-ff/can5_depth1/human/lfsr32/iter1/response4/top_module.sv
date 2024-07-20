module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [31:0] q_reg;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			q_reg <= 32'h1;
		else begin
			q[31] <= q_reg[22] ^ q_reg[1] ^ q_reg[0];
			q[30:0] <= q_reg[31:1];
			q_reg <= q;
		end
	end

endmodule
