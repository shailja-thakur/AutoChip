module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [31:0] q_reg; // Add a register to hold the current state of the LFSR

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q_reg <= 32'h1;
		end else begin
			q_reg <= {q_reg[30:0], q_reg[22]^q_reg[2]^q_reg[1]};
		end
	end
	
	assign q = q_reg; // Assign the output based on the register
	
endmodule
