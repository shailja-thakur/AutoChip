module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	reg [1:0] state;

	always @(posedge clk) begin
		if (reset)
			state <= 2'b00;
		else begin
			if (state == 2'b00) begin
				if (j)
					state <= 2'b01;
				else
					state <= 2'b00;
			end else begin // state is B
				if (k)
					state <= 2'b00;
				else
					state <= 2'b01;
			end
		end
	end

	always @(state) begin
		out = (state == 2'b01);
	end

endmodule
