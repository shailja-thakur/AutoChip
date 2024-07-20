module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg [1:0] state;
wire out;

// States
parameter OFF = 2'b0;
parameter ON = 2'b1;

// Synchronous Reset logic
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= OFF;
	else begin
		// State transition logic
		case (state)
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

// Output logic
always @(state) begin
	case (state)
		OFF: out <= 1'b0;
		ON: out <= 1'b1;
	endcase
end

endmodule
