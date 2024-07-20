module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);

	reg [3:0] shift_register;

	always @(posedge clk) begin
		if (count_ena) begin
			if (shift_ena) begin
				q <= 4'b0001;
			end else if (q > 4'b0000) begin
				q <= q - 1;
			end
		end else if (shift_ena) begin
			shift_register <= {data, shift_register[3:1]};
		end
	end

	always @(posedge clk) begin
		if (count_ena) begin
			if (shift_ena && q == 4'b0000) begin
				shift_register <= {data, shift_register[3:1]};
			end else begin
				shift_register <= shift_register;
			end
		end
	end

	assign q = shift_register;

endmodule
