module top_module (
	input clk,
	input reset,
	output reg [31:0] q
);

	// Define the feedback taps
	parameter TAP_1 = 1;
	parameter TAP_2 = 2;
	parameter TAP_3 = 22;
	parameter TAP_4 = 32;

	reg [31:0] reg_q;

	always @(posedge clk or posedge reset) begin
		if (reset)
			reg_q <= 32'h1;
		else begin
			reg_q[0] <= reg_q[TAP_1] ^ reg_q[TAP_2] ^ reg_q[TAP_3] ^ reg_q[TAP_4];
			reg_q[31:1] <= reg_q[30:0];
		end
	end

	assign q = reg_q;

endmodule
