module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

reg [1:0] state, next_state;

// combinational always block to determine next state
always @*
	begin
		case (state)
			0: if (j) next_state = 1; else next_state = 0;
			1: if (k) next_state = 0; else next_state = 1;
			default: next_state = 0;
		endcase
	end

// clocked always block to update the state
always @(posedge clk or posedge areset)
	begin
		if (areset)
			state <= 0;
		else
			state <= next_state;
	end

// assign out port based on current state
assign out = (state == 1) ? 1'b1 : 1'b0;

endmodule
