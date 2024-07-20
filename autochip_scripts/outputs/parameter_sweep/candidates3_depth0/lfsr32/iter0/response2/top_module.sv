module top_module(
	input clk,
	input reset,
	output reg [31:0] q);
	
	// internal registers
	reg [31:0] reg_q;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			reg_q <= 32'h1;
		end else begin
			// calculate next LFSR value
			reg_q <= {reg_q[30:0], reg_q[31]} ^ reg_q[21] ^ reg_q[1] ^ reg_q[0];
		end
	end
	
	assign q = reg_q;
endmodule
