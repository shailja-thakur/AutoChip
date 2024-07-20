module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	reg [1:0] state;
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b10; // Set initial state to B
		else begin
			case (state)
				2'b00: begin // State A
					if (in)
						state <= 2'b01; // Transition to A if input is 1
					else
						state <= 2'b10; // Transition to B if input is 0
				end
				2'b01: begin // State B
					if (in)
						state <= 2'b01; // Transition to B
					else
						state <= 2'b10; // Transition to A
				end
				default: state <= 2'b10; // Default to B state
			endcase
		end
	end

	assign out = (state == 2'b01); // Output is high if in state A, low otherwise

endmodule
