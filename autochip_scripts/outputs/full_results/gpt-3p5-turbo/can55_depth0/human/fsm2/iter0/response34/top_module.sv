module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);
	
	// Define the states
	parameter OFF = 0;
	parameter ON = 1;
	
	// Define the state register and next state variables
	reg [1:0] state_reg;
	reg [1:0] state_next;
	
	// Define the output register
	reg out_reg;
	
	// Synchronous state update process
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			// Asynchronous reset
			state_reg <= OFF;
		end else begin
			// Synchronous state update based on next state
			state_reg <= state_next;
		end
	end
	
	// Combinational logic for next state and output generation
	always @* begin
		case (state_reg)
			OFF: begin
				if (j) begin
					state_next = ON;
				end else begin
					state_next = OFF;
				end
				out_reg = 0;
			end
			
			ON: begin
				if (k) begin
					state_next = OFF;
				end else begin
					state_next = ON;
				end
				out_reg = 1;
			end
		endcase
	end
	
	// Output assignment
	assign out = out_reg;
	
endmodule
