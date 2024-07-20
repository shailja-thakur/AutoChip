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
	
	reg [1:0] current_state, next_state;
	
	// Output register
	reg out_reg;
	
	// Asynchronous reset
	always @(posedge areset) begin
		current_state <= OFF;
		out_reg <= 0;
	end
	
	// Sequential logic
	always @(posedge clk) begin
		current_state <= next_state;
		out_reg <= (current_state == ON) ? 1 : 0;
	end
	
	// Next state logic
	always @(*) begin
		case (current_state)
			OFF: begin
				if (j)
					next_state = ON;
				else
					next_state = OFF;
			end
			ON: begin
				if (k)
					next_state = OFF;
				else
					next_state = ON;
			end
		endcase
	end
	
	// Assign the output
	assign out = out_reg;
	
endmodule
