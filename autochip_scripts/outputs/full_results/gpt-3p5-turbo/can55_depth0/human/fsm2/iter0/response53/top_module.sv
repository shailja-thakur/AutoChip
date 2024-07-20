module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

reg [1:0] state;
wire next_state;

// State machine logic
always @(state or j or k or areset) begin
	case(state)
		0: if (areset) state <= 0; else if (j) state <= 1; else state <= 0;
		1: if (areset) state <= 0; else if (k) state <= 0; else state <= 1;
	endcase
end

// Output logic
always @(state or j or k) begin
	case(state)
		0: out <= 0;
		1: out <= 1;
	endcase
end

endmodule
