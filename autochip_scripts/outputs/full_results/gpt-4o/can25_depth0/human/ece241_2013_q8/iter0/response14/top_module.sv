module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	// State encoding
	typedef enum logic [1:0] {
		STATE_0 = 2'b00, // Initial state
		STATE_1 = 2'b01, // Found '1'
		STATE_2 = 2'b10  // Found '10'
	} state_t;

	state_t current_state, next_state;

	// State transition logic
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			current_state <= STATE_0;
		else
			current_state <= next_state;
		end
  
	// Next state logic and output logic
	always @(*) begin
		case (current_state)
			STATE_0: begin
				z = 1'b0;
				if (x)
					next_state = STATE_1;
				else
					next_state = STATE_0;
			end
			STATE_1: begin
				z = 1'b0;
				if (x)
					next_state = STATE_1;
				else
					next_state = STATE_2;
			end
			STATE_2: begin
				if (x) begin
					z = 1'b1; // Sequence 101 detected
					next_state = STATE_1;
				end
				else begin
					z = 1'b0;
					next_state = STATE_0;
				end
			end
			default: begin
				z = 1'b0;
				next_state = STATE_0;
			end
		endcase
	end
endmodule
