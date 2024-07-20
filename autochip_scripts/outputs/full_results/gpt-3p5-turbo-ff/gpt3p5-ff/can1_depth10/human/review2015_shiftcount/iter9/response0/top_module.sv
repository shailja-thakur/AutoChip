module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);

	/* Internal signals */
	reg [3:0] shift_register;
	reg [3:0] q_next;

	always @(posedge clk) begin
		// Update q_next based on shift_ena and data
		if (shift_ena) begin
			q_next[0] <= data;
			q_next[1] <= shift_register[0];
			q_next[2] <= shift_register[1];
			q_next[3] <= shift_register[2];
		end else if (count_ena) begin
			q_next <= q_next - 1;
		end
	end

	always @(posedge clk) begin
		shift_register <= q_next;
	end

	assign q = shift_register;

endmodule
