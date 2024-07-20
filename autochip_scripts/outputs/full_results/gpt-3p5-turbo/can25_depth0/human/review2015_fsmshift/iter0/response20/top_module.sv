module top_module(
	input clk,
	input reset,
	output shift_ena);
	
	// Define state enum for FSM
	typedef enum logic [1:0] {
		IDLE,
		ENABLE,
		DISABLE
	} state_t;
	
	// Declare FSM signals
	state_t current_state;
	state_t next_state;
	
	reg shift_ena;
	
	// FSM process
	always_ff @(posedge clk, posedge reset) begin
		if (reset) begin
			current_state <= IDLE;
			shift_ena <= 1'b0;
		end else begin
			current_state <= next_state;
			shift_ena <= (current_state == ENABLE) ? 1'b1 : 1'b0;
		end
	end
	
	// Next state logic
	always_comb begin
		case (current_state)
			IDLE: begin
				if (reset)
					next_state = ENABLE;
				else
					next_state = IDLE;
			end
			ENABLE: next_state = DISABLE;
			DISABLE: begin
				if (reset)
					next_state = ENABLE;
				else
					next_state = DISABLE;
			end
		endcase
	end
endmodule
