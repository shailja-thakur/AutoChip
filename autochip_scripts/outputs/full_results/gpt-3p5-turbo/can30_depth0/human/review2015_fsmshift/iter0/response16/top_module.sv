module top_module(
	input wire clk,
	input wire reset,
	output wire shift_ena);

	reg [1:0] state;
	reg [1:0] next_state;

	parameter S_IDLE = 2'b00;
	parameter S_DETECT = 2'b01;
	parameter S_SHIFT = 2'b10;

	always @(posedge clk, posedge reset)
	begin
		if (reset)
		begin
			state <= S_IDLE;
			shift_ena <= 0;
		end
		else
		begin
			state <= next_state;
			shift_ena <= (state == S_SHIFT);
		end
	end

	always @(state)
	begin
		case (state)
			S_IDLE: begin
				if (bit_pattern_detected)
					next_state <= S_DETECT;
				else
					next_state <= S_IDLE;
			end
			S_DETECT: begin
				next_state <= S_SHIFT;
			end
			S_SHIFT: begin
				next_state <= S_IDLE;
			end
			default: begin
				next_state <= S_IDLE;
			end
		endcase
	end

endmodule
