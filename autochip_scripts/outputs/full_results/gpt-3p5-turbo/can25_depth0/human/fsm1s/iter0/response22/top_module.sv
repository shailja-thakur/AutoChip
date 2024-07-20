module top_module (
	input clk,
	input in,
	input reset,
	output out
);

// Define states
parameter B = 1'b0;
parameter A = 1'b1;

// Define current state and next state
reg state_reg, state_next;

// Define output
reg out_reg;

// Synchronous reset
always @(posedge clk) begin
	if (reset)
		state_reg <= B;
	else
		state_reg <= state_next;
end

// Combinational logic
always @* begin
	case (state_reg)
		B: begin
			if (in)
				state_next = B;
			else
				state_next = A;
			
			out_reg = 1'b1;
		end
		A: begin
			if (in)
				state_next = A;
			else
				state_next = B;
			
			out_reg = 1'b0;
		end
	endcase
end

// Output assignment
assign out = out_reg;

endmodule
