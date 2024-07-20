module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// Define the states
	typedef enum logic [1:0] {
		A,
		B,
		C,
		D
	} state_t;

	// Define the state register and next state variable
	reg state_t state_reg, next_state;
	
	// Define the output wire
	wire out_wire;

	// Assign the output wire to the output port
	assign out = out_wire;

	// Sequential logic for state transition and output generation
	always @(posedge clk or posedge areset)
	begin
		// Synchronous reset
		if (areset)
			state_reg <= A;
		else
			state_reg <= next_state;
	end

	// Combiantional logic for next_state and out_wire generation
	always @(*)
	begin
		case (state_reg)
			A: begin
				if (in)
					next_state = B;
				else
					next_state = A;
				out_wire = 0;
			end
			B: begin
				if (in)
					next_state = B;
				else
					next_state = C;
				out_wire = 0;
			end
			C: begin
				if (in)
					next_state = D;
				else
					next_state = A;
				out_wire = 0;
			end
			D: begin
				if (in)
					next_state = B;
				else
					next_state = C;
				out_wire = 1;
			end
			default: begin
				next_state = A;
				out_wire = 0;
			end
		endcase
	end

endmodule
