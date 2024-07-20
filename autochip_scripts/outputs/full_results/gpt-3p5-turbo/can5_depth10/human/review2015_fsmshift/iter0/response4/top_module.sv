module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [2:0] state;
	reg [2:0] next_state;

	parameter S_RESET = 0;
	parameter S_SHIFT_ENA = 1;

	always @(posedge clk) begin
		if (reset) begin
			state <= S_RESET;
		end else begin
			state <= next_state;
		end
	end

	always @(state) begin
		case (state)
			S_RESET: begin
				next_state <= S_SHIFT_ENA;
			end
			S_SHIFT_ENA: begin
				next_state <= S_RESET;
			end
			default: begin
				next_state <= S_RESET;
			end
		endcase
	end

	always @(posedge clk) begin
		if (reset) begin
			shift_ena <= 1'b1;
		end else if (state == S_SHIFT_ENA) begin
			shift_ena <= 1'b1;
		end else begin
			shift_ena <= 1'b0;
		end
	end

endmodule
