module top_module (
  input clk,
  input j,
  input k,
  input reset,
  output reg out
);

	reg [1:0] state;

	always @(posedge clk) begin
		if (reset) begin
			state <= 2'b00;
		end else begin
			if (state == 2'b00) begin
				if (j) begin
					state <= 2'b01;
				end
			end else if (state == 2'b01) begin
				if (k) begin
					state <= 2'b00;
				end
			end
		end
	end

	always @(state) begin
		if (state == 2'b00) begin
			out <= 1'b0;
		end else if (state == 2'b01) begin
			out <= 1'b1;
		end
	end

endmodule
