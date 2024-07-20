module top_module (
	input clk,
	input in,
	input areset,
	output out
);

// Define state enum
typedef enum logic [1:0] {
	B,
	A
} state_t;

// Define signal to hold current state
reg state_reg;
state_reg = B;

// Define output signal
reg out_reg;

// Define combinational logic to determine next state and output
always_comb begin
	case(state_reg)
		B: begin
			if (areset == 1'b1)
				state_reg = B;
			else if (in == 1'b0)
				state_reg = A;
			else
				state_reg = B;
		end

		A: begin
			if (areset == 1'b1)
				state_reg = B;
			else if (in == 1'b0)
				state_reg = B;
			else
				state_reg = A;
		end
	endcase

	if (state_reg == B)
		out_reg = 1'b1;
	else
		out_reg = 1'b0;
end

// Define sequential logic to update state and output on each clock edge
always_ff @(posedge clk) begin
	state_reg <= state_reg;
	out <= out_reg;
end

endmodule
