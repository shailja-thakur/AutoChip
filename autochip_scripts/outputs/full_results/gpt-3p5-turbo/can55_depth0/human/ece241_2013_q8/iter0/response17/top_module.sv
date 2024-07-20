module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	
	// State enumeration
	typedef enum logic[1:0] {
		S0,
		S1,
		S2
	} state_t;
	
	reg state, next_state;
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			state <= S0;
		else
			state <= next_state;
	end
	
	// Next state and output logic
	always @(state or x) begin
		case (state)
			S0: begin
				if (x == 1'b1)
					next_state = S1;
				else
					next_state = S0;
				z = 1'b0;
			end
			S1: begin
				if (x == 1'b0)
					next_state = S2;
				else
					next_state = S1;
				z = 1'b0;
			end
			S2: begin
				if (x == 1'b1)
					next_state = S1;
				else
					next_state = S0;
				z = 1'b1;
			end
		endcase
	end
endmodule
