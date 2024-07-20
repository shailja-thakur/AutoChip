module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

// State encoding
typedef enum reg [1:0] {
	S0 = 2'b00,
	S1 = 2'b01,
	S2 = 2'b10
} state_t;

state_t state, next_state;

// State transition logic
always @(posedge clk or negedge aresetn) begin
	if (!aresetn)
		state <= S0;
	else
		state <= next_state;
end

// Next state logic and output logic
always @(*) begin
	case(state)
		S0: begin
			if (x)
				next_state = S1;
			else
				next_state = S0;
			z = 0;
		end
		
		S1: begin
			if (x)
				next_state = S1;
			else
				next_state = S2;
			z = 0;
		end
		
		S2: begin
			if (x)
				next_state = S1;
			else
				next_state = S0;
			z = x; // output 1 if x is 1 to recognize "101"
		end
		
		default: begin
			next_state = S0;
			z = 0;
		end
	endcase
end

endmodule
