module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

// Define the states
parameter OFF = 1'b0;
parameter ON = 1'b1;

// Define the current state and next state
reg [1:0] state, next_state;

// Define the output reg
reg out;

// Assign initial state and output values
initial begin
	state = OFF;
	out = 1'b0;
end

// Define state transition and next state logic
always @(posedge clk or posedge areset) begin
	if (areset) begin
		// Reset to OFF state
		state <= OFF;
		out <= 1'b0;
	end else begin
		// State transitions
		case (state)
			OFF: begin
				if (j)
					next_state = ON;
				else
					next_state = OFF;
			end
			ON: begin
				if (k)
					next_state = OFF;
				else
					next_state = ON;
			end
			default: begin
				next_state = state;
			end
		endcase
		state <= next_state;
	end
end

// Define output logic
always @(state) begin
	case (state)
		OFF: out = 1'b0;
		ON: out = 1'b1;
	endcase
end

endmodule
