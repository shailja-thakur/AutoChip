module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	typedef enum reg [1:0] {
		INIT,          // Initial state, waiting for reset to release
		NO_COMP,       // No 2's complementing (copy input to output)
		COMP           // 2's complementing (invert input bits)
	} state_t;

	state_t state, next_state;

	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= INIT; // When reset is asserted, go to the INIT state
		else
			state <= next_state; // Otherwise, transition to next state
	end

	always @(*) begin
		case(state)
			INIT: begin
				if (areset)
					next_state = INIT;
				else
					next_state = NO_COMP;
			end
			NO_COMP: begin
				if (x == 0)
					next_state = NO_COMP;
				else
					next_state = COMP;
			end
			COMP: begin
				if (areset)
					next_state = INIT;
				else
					next_state = COMP;
			end
			default: next_state = INIT;
		endcase
	end

	always @(posedge clk) begin
		if (state == INIT) begin
			z <= 0; // Initialize output to 0 during reset
		end 
		else if (state == NO_COMP) begin
			z <= x; // Output the input directly
		end 
		else if (state == COMP) begin
			z <= ~x; // Output the inverted input
		end
	end

endmodule
