module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// Define state encoding
	typedef enum logic [1:0] {
		S_IDLE = 2'b00,
		S_FIRST_ONE = 2'b01,
		S_COMPLEMENT = 2'b10
	} state_t;
	
	state_t state, next_state;

	always_ff @(posedge clk or posedge areset) begin
		if (areset) 
			state <= S_IDLE;
		else 
			state <= next_state;
	end

	// Next state logic
	always_comb begin
		case (state)
			S_IDLE: 
				next_state = x ? S_FIRST_ONE : S_IDLE;
			S_FIRST_ONE: 
				next_state = S_COMPLEMENT;
			S_COMPLEMENT: 
				next_state = S_COMPLEMENT;
			default: 
				next_state = S_IDLE;
		endcase
	end

	// Output logic
	always_ff @(posedge clk or posedge areset) begin
		if (areset)
			z <= 1'b0;
		else begin
			case (state)
				S_IDLE: 
					z <= x;
				S_FIRST_ONE: 
					z <= ~x;
				S_COMPLEMENT: 
					z <= ~x;
				default: 
					z <= 1'b0;
			endcase
		end
	end
	
endmodule
