module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	typedef enum reg [1:0] {
		IDLE = 2'b00,
		FLIP = 2'b01,
		START = 2'b10
	} state_t;
	
	state_t state, next_state;

    // State transition logic (sequential)
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= IDLE;
		else
			state <= next_state;
	end

    // State transition logic (combinational)
	always @(*) begin
		case (state)
			IDLE: begin
				if (areset)
					next_state = IDLE;
				else
					next_state = START;
			end
			START: begin
				if (x == 1)
					next_state = FLIP;
				else
					next_state = START;
			end
			FLIP: begin
				if (areset)
					next_state = IDLE;
				else
					next_state = FLIP;
			end
			default: next_state = IDLE;
		endcase
	end

    // Output logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			z <= 0;
		else
			case (state)
				IDLE: z <= 0;
				START: z <= ~x;
				FLIP: z <= x;
				default: z <= 0;
			endcase
	end

endmodule
