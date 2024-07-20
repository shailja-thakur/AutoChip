module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	reg [1:0] state; // 2-bit register to store the current state

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b00; // reset the state to A
		end else begin
			case (state)
				2'b00: begin // state A
					if (in) begin
						state <= 2'b01; // next state B
					end else begin
						state <= 2'b00; // next state A
					end
				end
				2'b01: begin // state B
					if (in) begin
						state <= 2'b01; // next state B
					end else begin
						state <= 2'b10; // next state C
					end
				end
				2'b10: begin // state C
					if (in) begin
						state <= 2'b11; // next state D
					end else begin
						state <= 2'b00; // next state A
					end
				end
				2'b11: begin // state D
					if (in) begin
						state <= 2'b01; // next state B
					end else begin
						state <= 2'b10; // next state C
					end
				end
				default: begin // should not reach here
					state <= 2'b00; // reset the state to A
				end
			endcase
		end
	end

	assign out = (state == 2'b11) ? 1'b1 : 1'b0; // output is set to 1 when in state D

endmodule
