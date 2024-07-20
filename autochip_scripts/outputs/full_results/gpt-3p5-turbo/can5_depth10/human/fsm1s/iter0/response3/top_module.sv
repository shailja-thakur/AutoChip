module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	reg [1:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b10; // B state
		else begin
			case (state)
				2'b10: begin // B state
					if (in)
						state <= 2'b10; // Stay in B state
					else
						state <= 2'b01; // Transition to A state
				end
				2'b01: begin // A state
					if (in)
						state <= 2'b01; // Stay in A state
					else
						state <= 2'b10; // Transition to B state
				end
				default: state <= 2'b10;
			endcase
		end
	end

	always @(state) begin
		case (state)
			2'b10: out = 1; // B state, out=1
			2'b01: out = 0; // A state, out=0
		endcase
	end

endmodule
