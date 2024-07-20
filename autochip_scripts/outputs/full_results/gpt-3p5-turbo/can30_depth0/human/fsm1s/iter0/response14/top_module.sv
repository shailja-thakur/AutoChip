module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	reg [1:0] state;
	
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state <= 2'b10; // B state
		else
		begin
			case(state)
				2'b10: // B state
					begin
						if (in)
							state <= 2'b10; // Stay in B state
						else
							state <= 2'b01; // Transition to A state
					end
				2'b01: // A state
					begin
						if (in)
							state <= 2'b01; // Stay in A state
						else
							state <= 2'b10; // Transition to B state
					end
				default: state <= 2'b10; // Default to B state
			endcase
		end
	end
	
	assign out = (state == 2'b10) ? 1'b1 : 1'b0;
	
endmodule
