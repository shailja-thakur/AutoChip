module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [31:0] reg_q;
	reg [31:0] feedback;

	always @(posedge clk or posedge reset) begin
		if (reset)
			reg_q <= 32'b1; // Reset output q to 32'h1
		else begin
			reg_q <= feedback;
		end
	end

	always @(reg_q) begin
		feedback[31] <= reg_q[31] ^ reg_q[21] ^ reg_q[1]; // Tap at bit position 32
		feedback[21] <= reg_q[21] ^ reg_q[1]; // Tap at bit position 22
		feedback[1] <= reg_q[1] ^ reg_q[0]; // Tap at bit position 2
		feedback[0] <= reg_q[0] ^ reg_q[31]; // Tap at bit position 1
	end

	assign q = reg_q;

endmodule
