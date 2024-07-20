module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// States
	typedef enum reg [1:0] {
		S0, // initial state
		S1, // detected '1'
		S2  // detected '10'
	} state_t;

	state_t state, next_state;

	always @(posedge clk or negedge aresetn) begin
		if (~aresetn)
			state <= S0;
		else
			state <= next_state;
		end
	end

	always @(*) begin
		z = 1'b0;
		case (state)
			S0: begin
				if (x) 
					next_state = S1;
				else 
					next_state = S0;
			end
			S1: begin
				if (x) 
					next_state = S1;
				else 
					next_state = S2;
			end
			S2: begin
				if (x) begin
					next_state = S1;
					z = 1'b1;
				end else 
					next_state = S0;
			end
			default: 
				next_state = S0;
		endcase
	end

endmodule
