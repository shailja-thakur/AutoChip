module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	typedef enum reg [1:0] {STATE_IDLE, STATE_NEGATE, STATE_PASS} state_t;
	reg state, next_state;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= STATE_IDLE;
			z <= 0;
		end else begin
			state <= next_state;
			case(next_state)
				STATE_IDLE: z <= 0;
				STATE_NEGATE: z <= ~x;
				STATE_PASS: z <= x;
				default: z <= 0;
			endcase
		end
	end

	always @(*) begin
		case(state)
			STATE_IDLE: begin
				if(!areset) next_state = STATE_NEGATE;
				else next_state = STATE_IDLE;
			end
			STATE_NEGATE: begin
				if(x == 1) 
					next_state = STATE_PASS;
				else 
					next_state = STATE_NEGATE;
			end
			STATE_PASS: begin
				next_state = STATE_PASS;
			end
			default: begin
				next_state = STATE_IDLE;
			end
		endcase
	end
endmodule
