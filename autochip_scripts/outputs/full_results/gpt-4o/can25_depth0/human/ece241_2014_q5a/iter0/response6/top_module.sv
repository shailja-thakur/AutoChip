module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// State encoding
	typedef enum reg {IDLE, INVERT, ADD_ONE} state_t;
	state_t current_state, next_state;

	// State transition logic
	always @(*) begin
		case (current_state)
			IDLE: begin
				if (!areset)
					next_state = INVERT;
				else
					next_state = IDLE;
			end
			INVERT: begin
				if (x == 1'b0)
					next_state = INVERT;
				else
					next_state = ADD_ONE;
			end
			ADD_ONE: begin
				next_state = ADD_ONE;
			end
			default: next_state = IDLE;
		endcase
	end

	// Output logic & state register update
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= IDLE;
			z <= 1'b0;
		end else begin
			current_state <= next_state;
			case (current_state)
				IDLE: z <= 1'b0;
				INVERT: z <= ~x;    // Inverting the input
				ADD_ONE: z <= z + 1;// Adding one once we encounter the first '1'
				default: z <= 1'b0;
			endcase
		end
	end

endmodule
