module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [3:0] state;
	reg [3:0] next_state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
			start_shifting <= 0;
		end else begin
			state <= next_state;
		end
	end

	always @* begin
		next_state = state;
		if (state == 0) begin
			if (data == 1'b1) begin
				next_state = 1;
			end
		end else if (state == 1) begin
			if (data == 1'b1) begin
				next_state = 2;
			end
		end else if (state == 2) begin
			if (data == 1'b0) begin
				next_state = 3;
			end
		end else if (state == 3) begin
			if (data == 1'b1) begin
				next_state = 4;
			end
		end else if (state == 4) begin
			if (data == 1'b1) begin
				next_state = 4;
			end else begin
				next_state = 0;
				start_shifting <= 1;
			end
		end
	end

endmodule
