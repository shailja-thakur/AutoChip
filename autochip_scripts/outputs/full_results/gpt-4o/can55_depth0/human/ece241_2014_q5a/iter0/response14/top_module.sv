module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	typedef enum reg [1:0] {STATE_IDLE, STATE_FIRST_ONE, STATE_COMPLEMENT} state_t;
	state_t state, next_state;

	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= STATE_IDLE;
		else
			state <= next_state;
	end

	always @* begin
		case (state)
			STATE_IDLE: begin
				if (~areset) next_state = STATE_FIRST_ONE;
				else next_state = STATE_IDLE;
			end
			STATE_FIRST_ONE: begin
				if (~x) next_state = STATE_FIRST_ONE;
				else next_state = STATE_COMPLEMENT;
			end
			STATE_COMPLEMENT: begin
				if (areset) next_state = STATE_IDLE;
				else next_state = STATE_COMPLEMENT;
			end
			default: next_state = STATE_IDLE;
		endcase
	end

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			z <= 1'b0;
		end
		else begin
			case (state)
				STATE_IDLE: begin
					z <= 1'b0;
				end
				STATE_FIRST_ONE: begin
					z <= x;
				end
				STATE_COMPLEMENT: begin
					z <= ~x;
				end
			endcase
		end
	end
endmodule
