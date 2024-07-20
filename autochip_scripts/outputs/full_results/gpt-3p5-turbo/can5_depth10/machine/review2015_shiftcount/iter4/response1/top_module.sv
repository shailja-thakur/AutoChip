module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q
);

	reg [3:0] q_next;

	always @(posedge clk) begin
		if (shift_ena) begin
			q_next <= data;
		end
		else if (count_ena) begin
			q_next <= q - 1;
		end
		else begin
			q_next <= q;
		end
	end

	always @(posedge clk) begin
		q <= q_next;
	end

endmodule
