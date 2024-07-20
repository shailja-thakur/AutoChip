module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

// Define states
typedef enum logic [1:0] {
	S0,
	S1,
	S2
} state_type;

// Define current state and next state
reg state_type curr_state, next_state;

// Assign initial state
initial begin
	curr_state = S0;
end

// Assign next state logic
always @(posedge clk or negedge aresetn) begin
	if (~aresetn) begin
		next_state = S0;
	end else begin
		case (curr_state)
			S0: begin
				if (x == 1'b1)
					next_state = S1;
				else
					next_state = S0;
			end
			S1: begin
				if (x == 1'b0)
					next_state = S2;
				else
					next_state = S0;
			end
			S2: begin
				if (x == 1'b1)
					next_state = S1;
				else
					next_state = S0;
			end
		endcase
	end
end

// Update current state
always @(posedge clk or negedge aresetn) begin
	if (~aresetn)
		curr_state <= S0;
	else
		curr_state <= next_state;
end

// Assign output signal
always @(curr_state) begin
	if (curr_state == S2)
		z = 1'b1;
	else
		z = 1'b0;
end

endmodule
