module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// Define states
	typedef enum logic [1:0] {
		S,
		S1,
		S10
	} state_e;

	reg [1:0] state, state_next;

	// Default initial state
	initial begin
		state = S;
	end

	// State transition logic
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= S;
		end else begin
			state <= state_next;
		end
	end

	// Output logic
	always @(state, x) begin
		case (state)
			S: begin
				if (x == 0) begin
					state_next = S;
				end else begin
					state_next = S1;
				end
				z = 0;
			end
			
			S1: begin
				if (x == 0) begin
					state_next = S10;
				end else begin
					state_next = S1;
				end
				z = 0;
			end
			
			S10: begin
				if (x == 0) begin
					state_next = S;
				end else begin
					state_next = S1;
				end
				z = x;
			end
		endcase
	end

endmodule
