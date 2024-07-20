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
	
	// Define the state variables
	reg state, next_state;
	
	// Define the output variable
	reg out;
	
	// Define the synchronous process for state update
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= OFF;
		end else begin
			state <= next_state;
		end
	end
	
	// Define the combinational logic for state transitions
	always @* begin
		case(state)
			ON: begin
				if (k) begin
					next_state = OFF;
				end else begin
					next_state = ON;
				end
			end
			
			OFF: begin
				if (j) begin
					next_state = ON;
				end else begin
					next_state = OFF;
				end
			end
			
			default: begin
				next_state = OFF;
			end
		endcase
	end
	
	// Define the output logic
	always @* begin
		case(state)
			ON: begin
				out = 1'b1;
			end
			
			OFF: begin
				out = 1'b0;
			end
		endcase
	end
endmodule
