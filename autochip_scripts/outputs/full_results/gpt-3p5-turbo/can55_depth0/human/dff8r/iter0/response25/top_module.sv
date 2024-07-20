module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);
	
	reg [7:0] q_reg; // create a register for storing the output
	
	always @(posedge clk) begin
		if (reset) begin
			q_reg <= 8'b0; // set register to zero on reset
		end else begin
			q_reg <= d; // assign input to register
		end
	end
	
	assign q = q_reg; // assign register to output
endmodule
