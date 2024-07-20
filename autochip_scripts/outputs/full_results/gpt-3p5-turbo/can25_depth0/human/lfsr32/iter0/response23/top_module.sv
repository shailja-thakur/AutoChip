module top_module(
	input clk,
	input reset,
	output reg [31:0] q);
	
	// internal signals
	reg [31:0] reg_q;
	
	// initial value for q
	assign q = (reset) ? 32'b1 : reg_q;
	
	always @(posedge clk) begin
		// update the shift register
		reg_q[31] <= reg_q[2] ^ reg_q[1] ^ reg_q[0];
		reg_q[30:0] <= reg_q[31:1];
	end

endmodule
