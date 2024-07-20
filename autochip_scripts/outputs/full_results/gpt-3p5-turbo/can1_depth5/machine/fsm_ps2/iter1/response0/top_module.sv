module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

// Define states for the state machine
typedef enum logic [1:0] {
	BYTE1,
	BYTE2,
	BYTE3,
	DONE
} state_type;

// Declare state and next_state variables
state_type state, next_state;

// Assign initial state
assign state = BYTE1;

always_ff @(posedge clk or posedge reset) begin
	if (reset) begin
		next_state <= BYTE1;
	end 
	else begin
		case (state)
			BYTE1: if (in[2] == 1) begin
						next_state <= BYTE2;
					end else begin
						next_state <= BYTE1;
					end
					
			BYTE2: next_state <= BYTE3;
			
			BYTE3: next_state <= DONE;
			
			DONE:  if (in[2] == 1) begin
						next_state <= BYTE2;
					end else begin
						next_state <= BYTE1;
					end
		endcase
	end
end

// Assign output
assign done = (state == DONE);

// Assign next state to current state
always_ff @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= BYTE1;
	end
	else begin
		state <= next_state;
	end
end

endmodule
