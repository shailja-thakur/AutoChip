module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);

	// Internal signals
	reg [3:0] shift_reg;
	reg [3:0] q_next;

	always @(posedge clk) begin
		// Shift register functionality
		if (shift_ena) begin
			shift_reg[3:1] <= shift_reg[2:0];
			shift_reg[0] <= data;
		end

		// Down counter functionality
		if (count_ena) begin
			if (shift_ena) begin
				q_next <= shift_reg;
			end else begin
				q_next <= q - 1;
			end
		end
	end

	always @(posedge clk) begin
		q <= q_next;
	end
endmodule
