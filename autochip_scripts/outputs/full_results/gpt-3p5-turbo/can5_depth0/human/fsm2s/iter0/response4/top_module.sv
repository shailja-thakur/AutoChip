module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg [1:0] state;
reg out;

// State definitions
parameter OFF = 2'b00;
parameter ON = 2'b01;

// Synchronous reset
always @(posedge clk) begin
	if (reset)
		state <= OFF;
	else begin
		case(state)
			OFF: begin
				if (j)
					state <= ON;
				else
					state <= OFF;
			end
			ON: begin
				if (k)
					state <= OFF;
				else
					state <= ON;
			end
		endcase
	end
end

// Output assignment
always @(state) begin
	case(state)
		OFF: out = 1'b0;
		ON: out = 1'b1;
	endcase
end

endmodule
