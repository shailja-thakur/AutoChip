module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	// State declaration
	reg [1:0] state, next_state;

	// Output declaration
	reg out_reg;

	// State definitions
	parameter OFF = 2'b00;
	parameter ON = 2'b01;

	// Asynchronous reset
	always @ (posedge areset)
		if (areset)
			state <= OFF;

	// State transition and output logic
	always @(posedge clk or negedge areset)
		if (~areset) begin
			state <= OFF;
			out_reg <= 0;
		end else begin
			state <= next_state;
			out_reg <= (state == ON) ? 1 : 0;
		end

	// Next state logic
	always @*
		case (state)
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
	
	// Output assignment
	assign out = out_reg;

endmodule
