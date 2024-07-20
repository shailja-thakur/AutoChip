module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// Enumerate the states
	typedef enum logic [1:0] {S, S1, S10} state_type;
	reg [1:0] state, state_next;

	always @(posedge clk or negedge aresetn) begin
		if (!aresetn) begin
			state <= S;   // Initialize state on reset
		end else begin
			state <= state_next;   // Assign state_next to state
		end
	end

	always @(state or x) begin
		case (state)
			S: begin
				if (x == 1'b0) begin
					state_next = S;
				end else begin
					state_next = S1;
				end
			end
			
			S1: begin
				if (x == 1'b0) begin
					state_next = S10;
				end else begin
					state_next = S1;
				end
			end
			
			S10: begin
				if (x == 1'b0) begin
					state_next = S;
				end else begin
					state_next = S1;
				end
			end
		endcase
	end
	
	assign z = (state == S10) ? x : 1'b0;
endmodule
