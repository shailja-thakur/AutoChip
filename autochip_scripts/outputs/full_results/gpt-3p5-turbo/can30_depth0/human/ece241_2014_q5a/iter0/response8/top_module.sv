module top_module (
  input clk,
  input areset,
  input x,
  output z
);


// Declare the states of the one-input one-output serial 2's complementer Moore state machine
typedef enum logic [1:0] {
	S0,
	S1
} State;


// Declare the signals
reg [1:0] state_reg, state_next;
reg z_reg, z_next;


// Assign the states and outputs in the next state logic
always_ff @(posedge clk or negedge areset) begin
	if (areset == 0) begin
		state_reg <= S0;
		z_reg <= 0;
	  // Reset condition, 2's complementer is idle
	end
	else begin
		state_reg <= state_next;
		z_reg <= z_next;
	end
end


// Assign the next states and outputs in the combinational logic
always_comb begin
	case (state_reg)
		S0: begin
			if (areset == 0 && x == 1)
				state_next = S1;
			else
				state_next = S0;
			z_next = z_reg;
		end

		S1: begin
			if (areset == 0 && x == 1)
				state_next = S1;
			else
				state_next = S0;
			z_next = ~z_reg + 1;
		end

		default: begin
			state_next = S0;
			z_next = 0;
		end
	endcase
end


// Assign the output to the current state
always_comb begin
	case (state_reg)
		S0: z = z_reg;
		S1: z = z_reg;
		default: z = 0;
	endcase
end

endmodule
