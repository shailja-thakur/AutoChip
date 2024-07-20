module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	reg [1:0] state;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b01;
		end else begin
			if (state == 2'b00) begin
				if (in) begin
					state <= 2'b00;
				end else begin
					state <= 2'b01;
				end
			end else begin
				if (in) begin
					state <= 2'b01;
				end else begin
					state <= 2'b00;
				end
			end
		end
	end

	always @(state) begin
		if (state == 2'b00) begin
			out <= 1'b0;
		end else begin
			out <= 1'b1;
		end
	end

endmodule
