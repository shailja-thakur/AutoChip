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
	} state_t;

	// Define state variables
	reg state, next_state;

	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= S;
		end else begin
			state <= next_state;
		end
	end

	always @(state or x) begin
		case (state)
			S: begin
				if (x == 1'b1) begin
					next_state = S1;
				end else begin
					next_state = S;
				end
			end

			S1: begin
				if (x == 1'b1) begin
					next_state = S1;
				end else begin
					next_state = S10;
				end
			end

			S10: begin
				if (x == 1'b1) begin
					next_state = S1;
				end else begin
					next_state = S;
				end
			end
		endcase
	end

	always @(state) begin
		case (state)
			S, S1: z = 1'b0;
			S10: z = x;
		endcase
	end
	
endmodule
