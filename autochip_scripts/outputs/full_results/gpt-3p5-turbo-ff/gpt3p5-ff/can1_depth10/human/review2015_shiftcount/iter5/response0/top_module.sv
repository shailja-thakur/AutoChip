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
			q_next[3:0] <= {q_next[2:0], data};
		end

		// Update q_next based on count_ena
		if (count_ena) begin
			q_next <= q_next - 1;
		end
	end

	always @(posedge clk) begin
		if (shift_ena || count_ena) begin
			shift_register <= q_next;
		end
	end

	assign q = shift_register;

endmodule
