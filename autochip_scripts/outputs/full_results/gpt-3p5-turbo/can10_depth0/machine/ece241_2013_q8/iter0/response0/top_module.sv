module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	/* Declare state variables */
	reg [3:0] state, next_state;
	
	/* Define states */
	parameter S = 4'b000, S1 = 4'b001, S10 = 4'b010;
	
	/* Define state transitions based on input x and current state */
	always@(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= S;
		end else begin
			case(state)
				S: begin
					if (x == 1'b0) begin
						next_state <= S;
					end else begin
						next_state <= S1;
					end
				end
				S1: begin
					if (x == 1'b0) begin
						next_state <= S10;
					end else begin
						next_state <= S1;
					end
				end
				S10: begin
					if (x == 1'b0) begin
						next_state <= S;
					end else begin
						next_state <= S1;
					end
				end
				default: begin
					next_state <= S;
				end
			endcase
		end
	end
	
	/* Update state */
	always@(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= S;
		end else begin
			state <= next_state;
		end
	end
	
	/* Define output based on current state */
	always@(state) begin
		case(state)
			S, S1: begin
				z <= 1'b0;
			end
			S10: begin
				z <= x;
			end
			default: begin
				z <= 1'b0;
			end
		endcase
	end

endmodule
