module top_module(
	input clk,
	input reset,
	output reg [31:0] q);
	
	reg [31:0] q_reg;
	reg [31:0] q_next;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q_reg <= 32'h1;
		end else begin
			q_reg <= q_next;
		end
	end
	
	always @* begin
		q_next = {q_reg[30:0], q_reg[31] ^ q_reg[21] ^ q_reg[1] ^ q_reg[0]};
	end
	
	assign q = q_reg;
	
endmodule
