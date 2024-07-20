module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);
	// Define states
	parameter OFF = 1'b0;
	parameter ON = 1'b1;
	
	// Define state register and next state
	reg state_reg;
	reg next_state;

	// Define output register
	reg out_reg;
	
	// Asynchronous reset to state OFF
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state_reg <= OFF;
			out_reg <= 1'b0;
		end else begin
			state_reg <= next_state;
			out_reg <= state_reg;
		end
	end
	
	// Assign next state and output based on the current state and inputs
	always @(state_reg or j or k) begin
		case(state_reg)
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
		endcase
	end
	
	// Assign output based on the current state
	assign out = out_reg;
endmodule
