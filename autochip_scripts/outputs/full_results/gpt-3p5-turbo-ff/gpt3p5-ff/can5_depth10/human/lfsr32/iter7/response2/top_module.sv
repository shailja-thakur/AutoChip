module top_module(
	input clk,
	input reset,
	output [31:0] q
);

	reg [31:0] q_reg;
	assign q = q_reg;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q_reg <= 32'h1;
		end else begin
			q_reg <= {q_reg[31:1], q_reg[22] ^ q_reg[2] ^ q_reg[1] ^ q_reg[0]};
		end
	end

endmodule
