module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);
	// Define the flip-flop
	reg q_reg;
	
	// Define the combinational logic
	assign state = (q_reg == 1'b1) ? 1'b1 : 1'b0;
	
	always @(posedge clk) begin
		// Update flip-flop on clock edge
		q_reg <= (a & ~b) | (b & state);
	end
	
	assign q = q_reg;
endmodule
