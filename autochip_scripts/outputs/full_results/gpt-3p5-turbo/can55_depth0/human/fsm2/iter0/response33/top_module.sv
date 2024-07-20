module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);
	// State enumeration
	typedef enum {
		OFF,
		ON
	} states;

	// State register
	reg [1:0] state_reg;
	reg [1:0] next_state;
	
	// Output register
	reg out_reg;

	// Assign initial state and output
	initial begin
		state_reg = OFF;
		out_reg = 0;
	end
	
	// Synchronous state and output update
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state_reg <= OFF;
			out_reg <= 0;
		end else begin
			state_reg <= next_state;
			out_reg <= (state_reg == ON) ? 1 : 0;
		end
	end

	// Next state logic
	always @* begin
		case (state_reg)
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
			default: next_state = OFF;
		endcase
	end
	
	// Output assign
	assign out = out_reg;
endmodule
