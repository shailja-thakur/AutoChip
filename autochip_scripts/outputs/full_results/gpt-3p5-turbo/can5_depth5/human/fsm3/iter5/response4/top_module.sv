module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	reg [1:0] state, next_state;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b00;
			next_state <= 2'b00;
			out <= 0;
		end else begin
			state <= next_state;
			case (state)
				2'b00: begin
					if (in) begin
						next_state = 2'b01;
					end else begin
						next_state = 2'b00;
					end
				end
				2'b01: begin
					if (in) begin
						next_state = 2'b10;
					end else begin
						next_state = 2'b01;
					end
				end
				2'b10: begin
					if (in) begin
						next_state = 2'b11;
					end else begin
						next_state = 2'b00;
					end
				end
				2'b11: begin
					if (in) begin
						next_state = 2'b10;
					end else begin
						next_state = 2'b10;
					end
					out <= 1;
				end
			endcase
		end
	end

endmodule
