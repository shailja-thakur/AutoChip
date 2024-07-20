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
		if (shift_ena && !count_ena) begin
			// Shift in data
			q_next[0] <= data;
			q_next[1] <= shift_register[0];
			q_next[2] <= shift_register[1];
			q_next[3] <= shift_register[2];
		end else if (!shift_ena && count_ena) begin
			// Decrement count
			q_next <= q_next - 1;
		end else begin
			// No operation
			q_next <= shift_register;
		end
	end

	always @(posedge clk) begin
		if (shift_ena || count_ena) begin
			shift_register <= q_next;
		end
	end

	assign q = q_next;

endmodule
