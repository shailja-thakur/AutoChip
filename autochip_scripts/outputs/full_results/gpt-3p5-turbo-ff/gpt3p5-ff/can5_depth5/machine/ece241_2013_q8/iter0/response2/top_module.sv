module top_module (
	input clk,
    input aresetn,
    input x,
    output reg z
);
	reg state, next_state;
	
	// Define state constants
	parameter S = 2'b00;
	parameter S1 = 2'b01;
	parameter S10 = 2'b10;

	// Define state next transitions
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= S;
		end else begin
			case (state)
				S: begin
					if (x) begin
						next_state <= S1;
					end else begin
						next_state <= S;
					end
				end
				S1: begin
					if (x) begin
						next_state <= S1;
					end else begin
						next_state <= S10;
					end
				end
				S10: begin
					if (x) begin
						next_state <= S1;
					end else begin
						next_state <= S;
					end
				end
				default: begin
					next_state <= S;
				end
			endcase
		end
	end
	
	// Assign output z based on state
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			z <= 0;
		end else begin
			case (state)
				S, S1: begin
					z <= 0;
				end
				S10: begin
					z <= x;
				end
				default: begin
					z <= 0;
				end
			endcase
		end
	end

endmodule
