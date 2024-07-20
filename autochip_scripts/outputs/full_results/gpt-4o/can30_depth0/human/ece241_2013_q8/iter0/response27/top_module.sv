module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// State encoding
	typedef enum logic [1:0] {
		IDLE = 2'b00,
		S1 = 2'b01,
		S10 = 2'b10
	} state_t;
	
	state_t state, next_state;
	
	// State register
	always_ff @(negedge aresetn, posedge clk) begin
		if (!aresetn) begin
			state <= IDLE;
		end else begin
			state <= next_state;
		end
	end
	
	// Next state logic
	always_comb begin
		case (state)
			IDLE: begin
				if (x) next_state = S1;
				else next_state = IDLE;
			end
			S1: begin
				if (x) next_state = S1;
				else next_state = S10;
			end
			S10: begin
				if (x) next_state = S1;
				else next_state = IDLE;
			end
			default: next_state = IDLE;
		endcase
	end
	
	// Output logic
	always_ff @(negedge aresetn, posedge clk) begin
		if (!aresetn) begin
			z <= 1'b0;
		end else begin
			case (state)
				IDLE: z <= 1'b0;
				S1: z <= 1'b0;
				S10: z <= x ? 1'b1 : 1'b0;
				default: z <= 1'b0;
			endcase
		end
	end
	
endmodule
