module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	reg [1:0] state;
	reg out;

	always @(posedge clk) begin
		if (reset) begin
			state <= 2'b00; // Reset state to A
			out <= 1'b0;
		end else begin
			case (state)
				2'b00: begin
					if (in) begin
						state <= 2'b01;
						out <= 1'b0;
					end else begin
						state <= 2'b00;
						out <= 1'b0;
					end
				end
				2'b01: begin
					if (in) begin
						state <= 2'b10;
						out <= 1'b0;
					end else begin
						state <= 2'b01;
						out <= 1'b0;
					end
				end
				2'b10: begin
					if (in) begin
						state <= 2'b00;
						out <= 1'b0;
					end else begin
						state <= 2'b11;
						out <= 1'b0;
					end
				end
				2'b11: begin
					if (in) begin
						state <= 2'b10;
						out <= 1'b1;
					end else begin
						state <= 2'b01;
						out <= 1'b0;
					end
				end
			endcase
		end
	end

endmodule
