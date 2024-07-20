module top_module (
	input clk,
	input in,
	input areset,
	output out
);

// Define the states
typedef enum logic [1:0] {B, A} state_type;

// Define the state register
reg state_type current_state, next_state;

// Define the output register
reg out_reg;

always_ff @(posedge clk or posedge areset) begin
	if (areset)
		current_state <= B;
	else
		current_state <= next_state;
end

always_comb begin
	case (current_state)
		B: begin
			if (in)
				next_state = A;
			else
				next_state = B;
		end
		A: begin
			if (in)
				next_state = A;
			else
				next_state = B;
		end
		default: next_state = B;
	endcase
end

always_ff @(posedge clk) begin
	case (current_state)
		B: out_reg = 1'b0;
		A: out_reg = 1'b1;
	endcase
end

assign out = out_reg;

endmodule
