module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [1:0] state;
	reg [1:0] next_state;

	parameter STATE_IDLE = 2'b00;
	parameter STATE_DETECT = 2'b01;
	parameter STATE_SHIFT = 2'b10;

	always @(posedge clk) begin
		if (reset) begin
			state <= STATE_IDLE;
			shift_ena <= 1'b0;
		end else begin
			state <= next_state;
			shift_ena <= (state == STATE_SHIFT);
		end
	end

	always @(state) begin
		case (state)
			STATE_IDLE:
				if (reset)
					next_state = STATE_IDLE;
				else if (/* add condition for detecting bit pattern */)
					next_state = STATE_DETECT;
				else
					next_state = STATE_IDLE;

			STATE_DETECT:
				if (reset)
					next_state = STATE_IDLE;
				else if (/* add condition for detecting bit pattern */)
					next_state = STATE_SHIFT;
				else
					next_state = STATE_IDLE;

			STATE_SHIFT:
				if (reset)
					next_state = STATE_IDLE;
				else
					next_state = STATE_IDLE;
		endcase
	end
endmodule
