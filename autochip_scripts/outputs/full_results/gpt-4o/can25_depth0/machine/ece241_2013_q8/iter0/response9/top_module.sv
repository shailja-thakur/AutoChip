module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// State definitions
	typedef enum reg [1:0] {
		S = 2'b00,
		S1 = 2'b01,
		S10 = 2'b10
	} state_t;
	
	state_t state, state_next;

	// State transition logic
	always @(*) begin
		case(state)
			S: begin
				if (x == 0) 
					state_next = S;
				else 
					state_next = S1;
			end
			S1: begin
				if (x == 0) 
					state_next = S10;
				else 
					state_next = S1;
			end
			S10: begin
				if (x == 0) 
					state_next = S;
				else 
					state_next = S1;
			end
			default: state_next = S;
		endcase
	end

	// State flip-flops
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			state <= S;
		else
			state <= state_next;
	end

	// Output logic
	always @(*) begin
		case(state)
			S: z = 0;
			S1: z = 0;
			S10: z = x;
			default: z = 0;
		endcase
	end

endmodule
