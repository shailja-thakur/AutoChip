module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);
	reg [1:0] state;
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 0;
		else
			case (state)
				0: begin // OFF state
					if (j) // transition to ON state if j=1
						state <= 1;
					else // stay in OFF state if j=0
						state <= 0;
				end
				1: begin // ON state
					if (k) // transition to OFF state if k=1
						state <= 0;
					else // stay in ON state if k=0
						state <= 1;
				end
			endcase
	end

	always @(state) begin
		case (state)
			0: out <= 0; // OFF state, set output to 0
			1: out <= 1; // ON state, set output to 1
		endcase
	end
endmodule
